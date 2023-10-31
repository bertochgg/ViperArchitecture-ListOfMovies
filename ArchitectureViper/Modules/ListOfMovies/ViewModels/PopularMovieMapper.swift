//
//  PopularMovieMapper.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 20/09/23.
//

import Foundation

struct PopularMovieMapper {
    // Mapper utilized to transform Model to ViewModel
    func map(entity: Result) -> PopularMovieViewModel {
        PopularMovieViewModel(title: entity.title,
                              poster: URL(string: "https://image.tmdb.org/t/p/w200" + entity.posterPath),
                              overview: entity.overview)
    }
}
