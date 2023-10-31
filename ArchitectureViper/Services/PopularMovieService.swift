//
//  PopularMovieService.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 18/09/23.
//

import UIKit

protocol PopularMovieServiceProtocol {
    func getListOfPopularMovies(completion: @escaping (Swift.Result<PopularMovie, NetworkServiceErrors>) -> Void)
}

class PopularMovieService: PopularMovieServiceProtocol {
    func getListOfPopularMovies(completion: @escaping (Swift.Result<PopularMovie, NetworkServiceErrors>) -> Void) {
        let apiKey = "bf9f4488381e903dd118f4110d1fd150"
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)")
        guard let safeUrl = url else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: safeUrl) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            switch httpResponse.statusCode {
            case 200..<300:
                // Decode
                guard let safeData = data else { return }
                self.jsonDecoder(json: safeData, completion: completion)
            default:
                completion(.failure(.invalidResponse))
            }
        }
        task.resume()
    }
    
    private func jsonDecoder(json: Any, completion: @escaping (Swift.Result<PopularMovie, NetworkServiceErrors>) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let popularMovieData = try decoder.decode(PopularMovie.self, from: jsonData)
            completion(.success(popularMovieData))
        } catch {
            completion(.failure(.decodeFailure))
        }
    }
}
