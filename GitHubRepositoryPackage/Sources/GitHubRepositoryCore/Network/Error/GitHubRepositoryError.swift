//
//  GitHubRepositoryError.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import Foundation

public enum GitHubRepositoryCustomError: LocalizedError, Equatable {
    case responseError(error: GitHubRepositoryResponseError)
    case unexpectedStatusCode(statusCode: Int)
    case notHTTPURLResponse
    case invalidRequestURL
    case failedToParse
    case customError(message: String)
    case unknownError

    public var errorDescription: String? {
        switch self {
        case .responseError(let error):
            return "【APIError】\(error.localizedDescription)"
        case .unexpectedStatusCode(let statusCode):
            return Localize.Error.unexpectedStatusCode(statusCode)
        case .invalidRequestURL:
            return Localize.Error.invalidRequestURL
        case .failedToParse:
            return "Failed to parse JSON"
        case .notHTTPURLResponse:
            return "Failed to convert to HTTPURLResponse"
        case .customError(let message):
            return message
        case .unknownError:
            return Localize.Error.unknown
        }
    }
}

public enum GitHubRepositoryResponseError: Int, LocalizedError, Equatable {

    // GitHub Error
    // Ref: // Ref: https://docs.github.com/ja/rest/search?apiVersion=2022-11-28#search-code--status-codes
    case notModified = 304
    case forbidden = 403
    case validationFailedOrEndpointSpammed = 422
    case serviceUnavailable = 503

    public var errorDescription: String? {
        let prefix = "ErrorCode:\(rawValue) "
        let errorMessage: String
        switch self {
        case .notModified:
            errorMessage = "Not modified"
        case .forbidden:
            errorMessage = "Forbidden"
        case .validationFailedOrEndpointSpammed:
            errorMessage = "Validation failed, or the endpoint has been spammed."
        case .serviceUnavailable:
            errorMessage = "Service unavailable"
        }
        return prefix + errorMessage
    }
}

public extension Error {
    var asCustomError: GitHubRepositoryCustomError {
        if let gitHubRepositoryCustomError = self as? GitHubRepositoryCustomError {
            return gitHubRepositoryCustomError
        } else {
            return .customError(message: localizedDescription)
        }
    }
}
