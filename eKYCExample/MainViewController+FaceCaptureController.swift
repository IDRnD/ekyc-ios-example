//
//  MainViewController+FaceCaptureController.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import Foundation
import IDLiveFaceCaptureIAD

// MARK: - Face Capture Controller Setup
extension MainViewController {
    func prepareFaceCaptureController() -> IDLiveFaceCaptureIAD.IDCameraController? {
        guard let vc = IDLiveFaceCaptureIAD.IDCameraController.instantiate() else { return nil }
        var faceDetectorSettings = FaceDetectorSettings()
        faceDetectorSettings.fireDelay = 1
        
        var engines = FaceDetectorEngines()
        engines.insert(.nativeVision)
        engines.insert(.faceDetectionSdk)
        
        faceDetectorSettings.useEngines(engines)
        
        vc.captureMode = .auto
        vc.useOvalMask(true)
        vc.faceDetectorSettings = faceDetectorSettings
        vc.prepareForIAD()
        vc.delegate = self
        return vc
    }
}
