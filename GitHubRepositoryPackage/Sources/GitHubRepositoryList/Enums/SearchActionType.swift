//
//  SearchActionType.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import Foundation

enum SearchActionType {
    case incrementalSearch(keywords: [String])
    case enterSearch(keywords: [String])

    var keywords: [String] {
        switch self {
        case .incrementalSearch(let keywords): return keywords
        case .enterSearch(let keywords): return keywords
        }
    }

    var shouldShowLoading: Bool {
        switch self {
        case .enterSearch:
            return true
        case .incrementalSearch:
            return false
        }
    }
}

extension SearchActionType: Equatable {}
