//
//  APIClient.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import Foundation

public final class APIClient: APIProtocol {
    public init() {}

    // 今回はGetのリクエストのみなので、Postなどの共通処理は実装しない
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
