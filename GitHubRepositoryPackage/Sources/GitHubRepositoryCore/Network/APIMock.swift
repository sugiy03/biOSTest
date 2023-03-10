//
//  APIMock.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/09.
//

import Foundation

public final class APIMock: APIProtocol {
    public init() {}

    public func sendRequest<R>(requestURL: URL) async throws -> R where R : Decodable {
        guard let url = GitHubRepositoryCore.bundleURL(fileName: "search_repositories_200_response", fileExtension: "json"),
              let data = try? Data(contentsOf: url)else {
            throw GitHubRepositoryCustomError.failedToParse
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // 今回はGitHubRepositoryModelしか使わないので、ForceTypeChangeしている
        return try decoder.decode(GitHubRepositoryModel.self, from: data) as! R
    }
}
