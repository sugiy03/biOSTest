//
//  APIProtocol.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import Foundation

public protocol APIProtocol {
    func sendRequest<R: Decodable>(requestURL: URL) async throws -> R
}
