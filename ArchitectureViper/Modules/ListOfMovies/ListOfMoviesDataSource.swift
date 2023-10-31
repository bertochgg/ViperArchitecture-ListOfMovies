//
//  ListOfMoviesDataSource.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 18/09/23.
//

import UIKit

protocol ListOfMoviesDataSourceProtocol: AnyObject, UITableViewDataSource {
    func updateData(with movies: [PopularMovieViewModel])
}

final class ListOfMoviesDataSource: NSObject, ListOfMoviesDataSourceProtocol {
    private var movies: [PopularMovieViewModel] = []
    
    func updateData(with movies: [PopularMovieViewModel]) {
        self.movies = movies
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(model: movies[indexPath.row])
        
        return cell
    }
    
}
