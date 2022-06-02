//
//  NetworkServiceMocks.swift
//  ExampleMVVMTests
//
//  Created by Oleh Kudinov on 16.08.19.
//

@testable import Common
import Foundation

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = .init(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
