//
//  NetworkSessionManagerMock.swift
//  ExampleMVVMTests
//
//  Created by Oleh Kudinov on 16.08.19.
//

@testable import Common
import Foundation

struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?

    func request(_: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable
    {
        completion(data, response, error)
        return URLSessionDataTask()
    }
}
