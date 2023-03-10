//
//  GitHubRepositoryDetailViewController+Test.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/08.
//

import UIKit

public enum GitHubRepositoryDetailTestIdentifier: String {
    private static let viewControllerId = "GitHubRepositoryDetailViewController"

    case avatarImageView
    case titleLabel
    case languageLabel
    case starsCountLabel
    case watchersCountLabel
    case forksCountLabel
    case issuesCountLabel
    case safariNavigationButton
    case safariNavigationBottomButton

    public var id: String {
        return GitHubRepositoryDetailTestIdentifier.viewControllerId + rawValue
    }
}
