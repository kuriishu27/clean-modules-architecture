//
//  MovieQueryEntity+Mapping.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 16.08.19.
//

import Foundation
import CoreData
import Persistence

public extension MovieQueryEntity {
    convenience init(movieQuery: MovieQuery, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        query = movieQuery.query
        createdAt = Date()
    }
}

public extension MovieQueryEntity {
    func toDomain() -> MovieQuery {
        return .init(query: query ?? "")
    }
}
