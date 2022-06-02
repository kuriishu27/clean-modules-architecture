//
//  PosterImagesRepositoryMock.swift
//  ExampleMVVMTests
//
//  Created by Oleh Kudinov on 17.08.19.
//

@testable import Common
import Foundation
@testable import MoviesModule
import XCTest

final class PosterImagesRepositoryMock: PosterImagesRepository {
    var expectation: XCTestExpectation?
    var error: Error?
    var image = Data()
    var validateInput: ((String, Int) -> Void)?

    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        validateInput?(imagePath, width)
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(image))
        }
        expectation?.fulfill()
        return nil
    }
}
