//
//  RepositoryTask.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 25.10.19.
//

import Common
import Foundation

public class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false

    public func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
