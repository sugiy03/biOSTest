//
//  Constants.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import Foundation

public enum Constants {
    public static let requestURLString = "https://api.github.com/search/repositories"
    public static func requestQueryURLString(query: String) -> String {
        "\(requestURLString)?q=\(query)"
    }
}
