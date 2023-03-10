//
//  GitHubRepositoryCore.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/11.
//

import Foundation

public final class GitHubRepositoryCore {
    static func bundleURL(fileName: String, fileExtension: String) -> URL? {
        Bundle.module.url(forResource: fileName, withExtension: fileExtension)
    }
}
