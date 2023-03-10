//
//  EmptyListTextType.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import Foundation
import GitHubRepositoryCore

enum EmptyListTextType {
    case searchNotDone
    case resultIsEmpty

    var text: String {
        switch self {
        case .searchNotDone:
            return Localize.GitHubRepositoryList.Search.notDone
        case .resultIsEmpty:
            return Localize.GitHubRepositoryList.Search.resultIsEmpty
        }
    }
}
