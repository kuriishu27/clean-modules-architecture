//
//  Movie.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation

public struct Movie: Equatable, Identifiable {
	public typealias Identifier = String
	public enum Genre {
		case adventure
		case scienceFiction
	}
	public let id: Identifier
	public let title: String?
	public let genre: Genre?
	public let posterPath: String?
	public let overview: String?
	public let releaseDate: Date?
}

public struct MoviesPage: Equatable {
	let page: Int
	let totalPages: Int
	let movies: [Movie]
}
