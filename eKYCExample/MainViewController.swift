//
//  MainViewController.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import UIKit
import IDLiveDocCaptureIAD
import IDLiveFaceCaptureIAD

class MainViewController: UIViewController {
    // MARK: - Network Service
    #warning("⚠️ Replace this with your API key")
    let networkService = NetworkService(url: "https://ekyc-rest-api.idrnd.net/check",
                                        apiKey: "YOUR_API_KEY_HERE")
    // MARK: - UI Components
    let mainView = MainView()
    var enrollButton: Button { mainView.enrollButton }
    var resetBarButton: UIBarButtonItem?
    var documentImageView: ImageView { mainView.documentImageView }
    var selfieImageView: ImageView { mainView.selfieImageView }
    
    enum CaptureType {
        case face
        case document
    }
    
    // MARK: Enrollment Data
    var enrollmentData = EnrollmentData() {
        didSet {
            update(with: enrollmentData)
        }
    }
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupNavBar()
    }
    
    // MARK: - Setup
    func setupActions() {
        mainView.captureSelfieButton.addTarget(self, action: #selector(captureSelfieTapped), for: .touchUpInside)
        mainView.captureDocumentButton.addTarget(self,action: #selector(captureDocumentTapped), for: .touchUpInside)
        mainView.enrollButton.addTarget(self, action: #selector(networkCallTapped), for: .touchUpInside)
        
        let selfieTap = UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap(_:)))
        selfieImageView.isUserInteractionEnabled = true
        selfieImageView.addGestureRecognizer(selfieTap)
        
        let documentTap = UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap(_:)))
        documentImageView.isUserInteractionEnabled = true
        documentImageView.addGestureRecognizer(documentTap)
    }
    
    func setupNavBar() {
        title = "eKYC Example"
        navigationController?.navigationBar.prefersLargeTitles = true
        let resetImage = UIImage(systemName: "trash")
        resetBarButton = UIBarButtonItem(image: resetImage, style: .plain, target: self, action: #selector(resetEnrollment))
        resetBarButton?.isEnabled = (enrollmentData.faceData != nil || enrollmentData.documentData != nil)
        navigationItem.rightBarButtonItem = resetBarButton
    }
    
    func update(with enrollmentData: EnrollmentData) {
        enrollButton.isEnabled = enrollmentData.isReady
        let hasAnyData = enrollmentData.faceData != nil || enrollmentData.documentData != nil
        resetBarButton?.isEnabled = hasAnyData
    }
    
    // MARK: - Action Handlers
    @objc func captureSelfieTapped() {
        handleCapture(for: .face)
    }
    
    @objc func captureDocumentTapped() {
        handleCapture(for: .document)
    }
    
    @objc func handleImageViewTap(_ gesture: UITapGestureRecognizer) {
        guard let tappedImageView = gesture.view as? UIImageView,
              let image = tappedImageView.image else {
            return
        }
        let previewVC = ImagePreviewController(image: image)
        present(previewVC, animated: true)
    }
        
    @MainActor
    func handleCapture(for type: CaptureType) {
        Task {
            guard await requestCameraAccess() else {
                self.showAlert(
                    title: "Camera Access Denied",
                    message: "Cannot capture without camera access."
                )
                return
            }
            
            let controller: UIViewController? = {
                switch type {
                case .face:
                    return self.prepareFaceCaptureController()
                case .document:
                    return self.prepareDocumentCaptureController()
                }
            }()
            
            if let vc = controller {
                vc.modalPresentationStyle = .pageSheet
                self.present(vc, animated: true)
            }
        }
    }
    // MARK: - Camera access
    func requestCameraAccess() async -> Bool {
        await withCheckedContinuation { continuation in
            IDLiveFaceCaptureIAD.IDCameraController.requestAccess { granted in
                continuation.resume(returning: granted)
            }
        }
    }
    
    // MARK: - Network call
    @objc func networkCallTapped() {
        // Ensure both data pieces are available
        guard let faceData = enrollmentData.faceData, let documentData = enrollmentData.documentData else {
            print("Enrollment data incomplete")
            return
        }
        
        enrollButton.setTitle("Processing...", for: .normal)
        enrollButton.isEnabled = false
        
        // Build CheckModel
        let faceSearchParams = FaceSearchParameters(collections: ["ekyc"], // at least one collection should be specified
                                                    limit: 1, // limit >= 1
                                                    maxFaces: 1) // max_faces >= 1
        // A list of face check pipelines
        let faceCheckPipelines: [FaceCheckPipeline] = [.init(type: .injectionAttack),
                                                       .init(type: .deepfakeAttack),
                                                       .init(type: .presentationAttack)]
        
        // FaceCheckParameters combine the domain and the chosen pipelines
        let faceCheckParams = FaceCheckParameters(domain: .general, pipelines: faceCheckPipelines)
        
        // Document pipelines
        let docPipelines: [DocumentCheckPipeline] = [.init(type: .portraitSubstitutionAttack),
                                                     .init(type: .printedCopyAttack),
                                                     .init(type: .screenReplayAttack)]
        
        // DocumentCheckParameters define the pipelines for document checks and errors to ignore (optional)
        let documentCheckParams = DocumentCheckParameters(pipelines: docPipelines,
                                                          errorsToIgnore: [.documentIsColorless])
        // Operations specify which checks to perform
        let operations: [EKYCOperation] = [.docCheck,
                                           .faceCheck,
                                           .faceMatchSearch,
                                           .faceMatchValidation]
        
        // Assemble everything into a single CheckModel object
        let checkModel = CheckModel(
            faceSearchParameters: faceSearchParams, // optional
            faceCheckParameters: faceCheckParams, // optional
            documentCheckParameters: documentCheckParams, // optional
            operations: operations // required
        )
        
        Task {
            // UI update to run after the network call
            defer {
                self.enrollButton.setTitle("Perform Request", for: .normal)
                self.enrollButton.isEnabled = true
            }
            
            do {
                let responseData = try await networkService.sendEnrollRequest(faceData: faceData,
                                                                              documentData: documentData,
                                                                              checkModel: checkModel)
                let responseString = String(data: responseData, encoding: .utf8) ?? "No response"
                let responseVC = ResponseViewController(response: responseString)
                let navController = UINavigationController(rootViewController: responseVC)
                self.present(navController, animated: true)
            } catch {
                let errorMessage: String
                if let enrollmentError = error as? NetworkError, case let .badResponse(rawResponse) = enrollmentError {
                    errorMessage = "Network call failed: \(rawResponse)"
                } else {
                    errorMessage = "Network call failed: \(error)"
                }
                
                self.showAlert(title: "Error", message: errorMessage)
            }
        }
    }
    
    // MARK: - Enrollment Reset
    @objc func resetEnrollment() {
        enrollmentData = EnrollmentData()
        selfieImageView.image = nil
        documentImageView.image = nil
        print("Enrollment has been reset")
    }
}
