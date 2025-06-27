//
//  AppDelegate.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import UIKit
import IDLiveDocCaptureIAD
import IDLiveFaceCaptureIAD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #warning("⚠️ Replace this with your license keys")
        let docDetectorKey = "YOUR_DOCUMENT_DETECTOR_LICENSE_KEY_HERE"
        let faceDetectorKey = "YOUR_FACE_DETECTOR_LICENSE_KEY_HERE"
                
        do {
            try License.setLicense(docDetectorKey, licenseType: .documentDetector)
            try License.setLicense(faceDetectorKey, licenseType: .faceDetector)
            
        } catch {
            print(error)
        }
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

