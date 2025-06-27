//
//  MainViewController+DocumentCaptureDelegate.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import UIKit
import IDLiveDocCaptureIAD

// MARK: - IDLiveDocCaptureIAD.IDCameraControllerDelegate
extension MainViewController: IDCameraControllerDelegate {
    // Called when a document image is captured (automatically or manually).
    // Example: Dismiss the camera, display the captured image in a preview, process and verify captured image.
    func cameraController(_ controller: IDCameraController, didCaptureImage image: UIImage) {
        // Update UI
        documentImageView.image = image
        // Update enrollment data with the captured document image
        do {
            let documentData = try controller.createIADBundle()
            enrollmentData.documentData = documentData
        } catch {
            print(error.localizedDescription)
        }
        // Dismiss the controller
        controller.dismiss(animated: true)
    }
    
    // Called whenever a detection result is updated.
    func cameraController(_ controller: IDCameraController, didUpdateDetectionResult result: DocumentDetectionResult, image: UIImage) { }
    
    // Handle any runtime errors.
    // Common practice: Log the error and dismiss the controller if it can’t continue.
    func cameraController(_ controller: IDCameraController, didEncounterError error: any Error) { }
    
    // Called whenever the live image has been updated.
    // Accessible it for processing.
    func cameraController(_ controller: IDCameraController, didUpdateLiveImage image: UIImage) { }
    
    // Called when the camera view mode change
    // Update UI elements or instructions for the user here.
    func cameraController(_ controller: IDCameraController, didUpdateViewMode viewMode: ViewMode) { }
}
