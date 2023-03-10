//
//  ErrorHandler.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import Foundation

final class ErrorHandler {
    static func handleHttpError(statusCode: Int) throws {
        guard let responseError = GitHubRepositoryResponseError(rawValue: statusCode) else {
            throw GitHubRepositoryCustomError.unexpectedStatusCode(statusCode: statusCode)
        }
        throw GitHubRepositoryCustomError.responseError(error: responseError)
    }
}
