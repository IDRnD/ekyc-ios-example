//
//  NetworkService.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import Foundation

// MARK: - NetworkService
class NetworkService {
    let ekycAPIKey: String
    let url: String
    
    init(url: String, apiKey: String) {
        self.url = url
        self.ekycAPIKey = apiKey
    }
    
    func sendEnrollRequest(faceData: Data, documentData: Data, checkModel: CheckModel, encrypted: Bool = true) async throws -> Data {
        // Create URLComponents from the base URL
        guard var urlComponents = URLComponents(string: url) else {
            throw URLError(.badURL)
        }
        
        // Set the query
        urlComponents.queryItems = [
            URLQueryItem(name: "encrypted", value: "\(encrypted)")
        ]
        
        // Create the final URL
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(ekycAPIKey, forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Create boundary and set Content-Type
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Build the request body using the helper
        let body = try makeMultipartBody(
            faceData: faceData,
            documentData: documentData,
            checkModel: checkModel,
            boundary: boundary
        )
        
        // Assign the body to the request
        request.httpBody = body
        
        // Perform the network call
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        if httpResponse.statusCode != 200 {
            let rawResponse = String(data: data, encoding: .utf8) ?? "nil"
            print("Raw Response: \(rawResponse)")
            throw NetworkError.badResponse(rawResponse: rawResponse)
        }
        
        return data
    }
    
    // MARK: - Build Multipart Body
    func makeMultipartBody(
        faceData: Data,
        documentData: Data,
        checkModel: CheckModel,
        boundary: String
    ) throws -> Data {
        var body = Data()
        
        // Append face data
        appendFilePart(body: &body,
                       boundary: boundary,
                       name: "face",
                       filename: "face",
                       mimeType: "application/octet-stream",
                       fileData: faceData)
        
        // Append document data
        appendFilePart(body: &body,
                       boundary: boundary,
                       name: "doc",
                       filename: "document",
                       mimeType: "application/octet-stream",
                       fileData: documentData)
        
        // Encode checkModel to JSON
        let encoder = JSONEncoder()
        let checkModelData = try encoder.encode(checkModel)
        
        // Append the checkModel JSON
        appendFilePart(body: &body,
                       boundary: boundary,
                       name: "checkModel",
                       filename: "checkModel.json",
                       mimeType: "application/json",
                       fileData: checkModelData)
        
        // Close the multipart form
        body.append("--\(boundary)--\r\n")
        
        return body
    }
    
    // Helper to append file parts
    func appendFilePart(body: inout Data, boundary: String, name: String, filename: String, mimeType: String, fileData: Data) {
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimeType)\r\n\r\n")
        body.append(fileData)
        body.append("\r\n")
    }
}
