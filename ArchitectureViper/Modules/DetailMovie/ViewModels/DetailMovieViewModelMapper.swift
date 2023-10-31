//
//  DetailMovieViewModelMapper.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 20/09/23.
//

import Foundation

struct DetailMovieViewModelMapper {
    func map(entity: DetailMovieEntity) -> DetailMovieViewModel {
        .init(title: entity.title,
              overview: entity.overview,
              backdropPath: URL(string: "https://image.tmdb.org/t/p/w200" + entity.backdropPath))
    }
}
