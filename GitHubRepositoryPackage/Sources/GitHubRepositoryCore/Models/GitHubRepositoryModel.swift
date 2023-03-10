//
//  GitHubRepositoryItemModel.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit

public struct GitHubRepositoryModel: Decodable, Sendable {
    public let items: [GitHubRepositoryItemModel]
}

public struct GitHubRepositoryItemModel: Decodable, Sendable {
    // Used in List
    public let fullName: String
    public let language: String?

    // Used in Detail
    public let stargazersCount: Int
    public let watchersCount: Int
    public let forksCount: Int
    public let openIssuesCount: Int
    public let owner: GitHubRepositoryOwnerModel

    public static let mock: GitHubRepositoryItemModel = .init(
        fullName: "apple/swift",
        language: "Swift",
        stargazersCount: 62000,
        watchersCount: 2500,
        forksCount: 10000,
        openIssuesCount: 10000,
        owner: .mock)

    enum CodingKeys: String, CodingKey {
        case fullName
        case language
        case stargazersCount
        case watchersCount
        case forksCount
        case openIssuesCount
        case owner
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try container.decode(String.self, forKey: .fullName)
        language = try container.decode(String?.self, forKey: .language)
        stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)
        watchersCount = try container.decode(Int.self, forKey: .watchersCount)
        forksCount = try container.decode(Int.self, forKey: .forksCount)
        openIssuesCount = try container.decode(Int.self, forKey: .openIssuesCount)
        owner = try container.decode(GitHubRepositoryOwnerModel.self, forKey: .owner)
    }

    public init(fullName: String,
                language: String,
                stargazersCount: Int,
                watchersCount: Int,
                forksCount: Int,
                openIssuesCount: Int,
                owner: GitHubRepositoryOwnerModel) {
        self.fullName = fullName
        self.language = language
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.forksCount = forksCount
        self.openIssuesCount = openIssuesCount
        self.owner = owner
    }
}

public struct GitHubRepositoryOwnerModel: Decodable, Sendable {
    public let avatarImageType: ImageType
    public let htmlUrl: URL

    public static let mock: GitHubRepositoryOwnerModel = .init(
        avatarImageType: .uiImage(uiImage: UIImage(systemName: "apple.logo")!),
        htmlUrl: URL(string: "https://github.com/apple/swift")!)

    enum CodingKeys: String, CodingKey {
        case avatarUrl
        case htmlUrl
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let avatarImageURL = try container.decode(URL.self, forKey: .avatarUrl)
        avatarImageType = .imageURL(URL: avatarImageURL)
        htmlUrl = try container.decode(URL.self, forKey: .htmlUrl)
    }

    public init(avatarImageType: ImageType, htmlUrl: URL) {
        self.avatarImageType = avatarImageType
        self.htmlUrl = htmlUrl
    }
}

extension ImageType: @unchecked Sendable {}
