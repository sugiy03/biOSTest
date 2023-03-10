//
//  APIClient.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import Foundation

public final class APIClient: APIProtocol {
    public init() {}

    // Since this time it is only a Get request, common processing such as Post will not be implemented.
    public func sendRequest<R: Decodable>(requestURL: URL) async throws -> R {
        let (data, urlResponse) = try await URLSession.shared.data(from: requestURL)
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            throw GitHubRepositoryCustomError.notHTTPURLResponse
        }
        if httpURLResponse.statusCode != 200 {
            try ErrorHandler.handleHttpError(statusCode: httpURLResponse.statusCode)
        }
        let encoder = JSONDecoder()
        encoder.keyDecodingStrategy = .convertFromSnakeCase
        return try encoder.decode(R.self, from: data)
    }
}
