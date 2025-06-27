//
//  EnrollmentData.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import Foundation

struct EnrollmentData {
    var faceData: Data?
    var documentData: Data?
    
    var isReady: Bool {
        return faceData != nil && documentData != nil
    }
}
