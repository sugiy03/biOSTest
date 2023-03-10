//
//  GitHubRepositoryDetailViewModel.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/07.
//

import Foundation
import GitHubRepositoryCore

final class GitHubRepositoryDetailViewModel {

    let model: GitHubRepositoryItemModel

    init(model: GitHubRepositoryItemModel) {
        self.model = model
    }

    deinit {
        Logger.debugDeinit()
    }
}
