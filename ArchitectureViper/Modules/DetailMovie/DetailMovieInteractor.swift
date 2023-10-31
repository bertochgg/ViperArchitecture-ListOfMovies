//
//  DetailMovieInteractor.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 20/09/23.
//

import Foundation

enum InteractorError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .networkError(let error):
            return "\(error) detected"
        case.decodingError(let error):
            return "\(error) detected"
        }
    }
}

protocol DetailMovieInteractorProtocol: AnyObject {
    func getDetailMovies(id: String, completion: @escaping (Swift.Result<DetailMovieEntity, InteractorError>) -> Void) async
}

final class DetailMovieInteractor: DetailMovieInteractorProtocol {
    
    func getDetailMovies(id: String, completion: @escaping (Swift.Result<DetailMovieEntity, InteractorError>) -> Void) async {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Constants.apiKey)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let detailMovie = try jsonDecoder.decode(DetailMovieEntity.self, from: data)
                completion(.success(detailMovie))
            } catch {
                if let urlError = error as? URLError {
                    completion(.failure(.networkError(urlError)))
                } else {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
