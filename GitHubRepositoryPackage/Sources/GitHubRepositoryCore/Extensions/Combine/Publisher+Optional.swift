//
//  Publisher+Optional.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/10.
//

import Foundation
import Combine

// Ref: https://qiita.com/rizumita/items/09347978010403395982
public protocol OptionalType {
    associatedtype Wrapped

    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { self }
}

public extension Publisher where Output: OptionalType {
    func unwrap() -> AnyPublisher<Output.Wrapped, Failure> {
        return flatMap { output -> AnyPublisher<Output.Wrapped, Failure> in
            guard let output = output.optional else {
                return Empty<Output.Wrapped, Failure>().eraseToAnyPublisher()
            }
            return Just(output).setFailureType(to: Failure.self)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

extension AnyPublisher where Output == String?, Failure == Never {
  var orEmpty: AnyPublisher<String, Never> {
    map { $0 ?? "" }.eraseToAnyPublisher()
  }
}
