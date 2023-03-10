//
//  ProcessInfo.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/09.
//

import Foundation

public extension ProcessInfo {
    var isUITest: Bool {
        return arguments.contains(ProcessArgumentsKind.uiTest.rawValue)
    }

    var isUnitTest: Bool {
        return environment["XCTestConfigurationFilePath"] != nil
    }
}
