//
//  MainViewController+DocumentCaptureController.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import Foundation
import IDLiveDocCaptureIAD

// MARK: -  Document Capture Controller Setup
extension MainViewController {
    func prepareDocumentCaptureController() -> IDLiveDocCaptureIAD.IDCameraController {
        let attackDetection: AttackType = .injection
        let idCardBoundingBox = DocumentDetector.standartIDCardBoundingBox()
        let vc = IDCameraController.instantiate(
            attackDetection: attackDetection,
            delegate: self,
            imageBoundingBox: idCardBoundingBox
        )
        
        return vc
    }
}
