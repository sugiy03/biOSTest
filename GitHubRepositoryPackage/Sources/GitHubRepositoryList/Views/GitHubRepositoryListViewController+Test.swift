//
//  GitHubRepositoryListViewController+Test.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/07.
//

import UIKit

public enum GitHubRepositoryListTestIdentifier: String {
    private static let viewControllerId = "GitHubRepositoryListViewController"

    case tableView

    public var id: String {
        return GitHubRepositoryListTestIdentifier.viewControllerId + rawValue
    }
}
