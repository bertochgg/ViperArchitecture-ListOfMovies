//
//  ListOfMoviesInteractor.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 14/09/23.
//

import Foundation

protocol ListOfMoviesInteractorProtocol {
    func fetchListOfMovies()
    func getListOfMovies() async -> PopularMovie
}

final class ListOfMoviesInteractor: ListOfMoviesInteractorProtocol {
    private let popularMovieService: PopularMovieServiceProtocol = PopularMovieService()
    
    func fetchListOfMovies() {
        popularMovieService.getListOfPopularMovies { result in
            switch result {
            case .success(let data):
                print(data.results.first?.originalTitle as Any)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getListOfMovies() async -> PopularMovie {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(Constants.apiKey)")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(PopularMovie.self, from: data)
    }
}

final class ListOfMoviesInteractorMock: ListOfMoviesInteractorProtocol {
    func fetchListOfMovies() {
        
    }
    
    func getListOfMovies() async -> PopularMovie {
        let results = [Result(adult: true,
                              backdropPath: "aodks",
                              genreIDS: [10,10],
                              id: 1,
                              originalTitle: "adad",
                              overview: "asdasd",
                              popularity: 10.2,
                              posterPath: "asdda.asdad",
                              releaseDate: "asd/asd/sd",
                              title: "asdasdwqe",
                              video: true,
                              voteAverage: 10.3,
                              voteCount: 10)]
        return PopularMovie(page: 10, results: results, totalPages: 10, totalResults: 10)
    }
    
    
}
