//
//  MoviesResponseStorage.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 05/04/2020.
//

import Foundation
import Persistence

protocol MoviesResponseStorage {
    func getResponse(for request: MoviesRequestDTO, completion: @escaping (Result<MoviesResponseDTO?, CoreDataStorageError>) -> Void)
    func save(response: MoviesResponseDTO, for requestDto: MoviesRequestDTO)
}
