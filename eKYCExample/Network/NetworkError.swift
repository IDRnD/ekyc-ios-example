//
//  NetworkError.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badResponse(rawResponse: String)
}
