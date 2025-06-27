//
//  CheckModel.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import Foundation

// MARK: - CheckModel
/// The overall CheckModel combining face search, face check, and document check parameters, plus operations.
struct CheckModel: Codable {
    var faceSearchParameters: FaceSearchParameters? = nil
    var faceCheckParameters: FaceCheckParameters? = nil
    var documentCheckParameters: DocumentCheckParameters? = nil
    let operations: [EKYCOperation]
    
    enum CodingKeys: String, CodingKey {
        case faceSearchParameters = "face_search_parameters"
        case faceCheckParameters  = "face_check_parameters"
        case documentCheckParameters = "document_check_parameters"
        case operations
    }
}

// MARK: - Face Search
struct FaceSearchParameters: Codable {
    let collections: [String]
    let limit: Int
    let maxFaces: Int
    
    enum CodingKeys: String, CodingKey {
        case collections
        case limit
        case maxFaces = "max_faces"
    }
}

// MARK: - Face Check
/// Face check parameters, containing domain and an array of pipeline objects.
struct FaceCheckParameters: Codable {
    let domain: FaceCheckDomain
    var pipelines: [FaceCheckPipeline]? = nil
}

/// Possible domains for face check.
enum FaceCheckDomain: String, Codable {
    case general = "GENERAL"
}

/// Each pipeline in face_check_parameters is an object with type, pipeline, and calibration.
struct FaceCheckPipeline: Codable {
    let type: FaceCheckPipelineType
    var pipeline: String? = nil
    var calibration: FaceCheckCalibration? = nil
}

/// Possible pipeline types for face check.
enum FaceCheckPipelineType: String, Codable {
    case presentationAttack = "PRESENTATION_ATTACK"
    case deepfakeAttack     = "DEEPFAKE_ATTACK"
    case injectionAttack    = "INJECTION_ATTACK"
}

/// Possible calibration levels for face check.
enum FaceCheckCalibration: String, Codable {
    case regular = "REGULAR"
    case soft    = "SOFT"
    case hard    = "HARD"
}

// MARK: - Document Check
/// Document check parameters, containing an array of pipeline objects and errors to ignore.
struct DocumentCheckParameters: Codable {
    let pipelines: [DocumentCheckPipeline]
    var errorsToIgnore: [DocumentErrorToIgnore]? = nil
    
    enum CodingKeys: String, CodingKey {
        case pipelines
        case errorsToIgnore = "errors_to_ignore"
    }
}

/// Each pipeline in document_check_parameters is an object with type, pipeline, and calibration.
struct DocumentCheckPipeline: Codable {
    let type: DocumentCheckPipelineType
    var pipeline: String? = nil
    var calibration: DocumentCheckCalibration? = nil
}

/// Possible pipeline types for document check.
enum DocumentCheckPipelineType: String, Codable {
    case screenReplayAttack         = "SCREEN_REPLAY_ATTACK"
    case printedCopyAttack          = "PRINTED_COPY_ATTACK"
    case portraitSubstitutionAttack = "PORTRAIT_SUBSTITUTION_ATTACK"
}

/// Possible calibration levels for document check.
enum DocumentCheckCalibration: String, Codable {
    case regular = "REGULAR"
    case soft    = "SOFT"
    case hard    = "HARD"
}

/// Possible document errors to ignore.
enum DocumentErrorToIgnore: String, Codable {
    case documentCropped     = "DOCUMENT_CROPPED"
    case documentIsColorless = "DOCUMENT_IS_COLORLESS"
}

// MARK: - Operations Enum
/// Possible operations to include in the `operations` array.
enum EKYCOperation: String, Codable {
    case faceCheck           = "FACE_CHECK"
    case docCheck            = "DOC_CHECK"
    case faceMatchValidation = "FACE_MATCH_VALIDATION"
    case faceMatchSearch     = "FACE_MATCH_SEARCH"
}
