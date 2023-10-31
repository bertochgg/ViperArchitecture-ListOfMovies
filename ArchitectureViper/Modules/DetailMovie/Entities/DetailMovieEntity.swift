//
//  DetailMovieEntity.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 20/09/23.
//

import Foundation

struct DetailMovieEntity: Codable {
    let title: String
    let overview: String
    let backdropPath: String
    let status: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
}
