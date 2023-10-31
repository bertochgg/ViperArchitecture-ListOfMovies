//
//  PopularMovieResponseEntity.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 18/09/23.
//

import Foundation

struct PopularMovieResponse: Decodable {
    let results: [PopularMovie]
}
