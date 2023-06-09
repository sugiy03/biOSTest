//
//  XCTContext+runActivityAsync.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import XCTest

// Ref: https://github.com/koher/swift-async-test-experiment/blob/main/Tests/AsyncTestExperimentTests/XCTContext+runActivityAsync.swift
public extension XCTContext {
    @MainActor
    static func runActivityAsync<Result>(
        named name: String,
        block: @escaping (XCTActivity) async -> Result) async -> Result {
        await withCheckedContinuation { continuation in
            let _: Void = runActivity(named: name, block: { activity in
                Task {
                    let result = await block(activity)
                    continuation.resume(returning: result)
                }
            })
        }
    }
}
