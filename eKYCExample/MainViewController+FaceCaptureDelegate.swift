//
//  MainViewController+FaceCaptureDelegate.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import UIKit
import IDLiveFaceCaptureIAD

// MARK: - IDLiveFaceCaptureIAD.IDCameraControllerDelegate
extension MainViewController: IDCameraControllerDelegate {
    func cameraController(_ controller: IDCameraControllerBase, didCaptureImage image: IDImage) {
        // Update UI
        selfieImageView.image = image.uiImage
        // Update enrollment data with the captured face image
        
        do {
            let faceData = try controller.createIADBundle()
            enrollmentData.faceData = faceData
        } catch {
            print(error.localizedDescription)
        }
        
        // Dismiss the controller
        controller.dismiss(animated: true)
    }
    
    func cameraController(_ controller: IDCameraControllerBase, didEncounterError error: IDCameraControllerBase.Error) { }
    
    func cameraControllerUserDidPressResultButton(_ controller: IDCameraControllerBase) {}
}
