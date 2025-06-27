//
//  Data+Append.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
