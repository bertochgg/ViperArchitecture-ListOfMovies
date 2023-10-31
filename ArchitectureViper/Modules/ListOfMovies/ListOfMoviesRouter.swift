//
//  ListOfMoviesRouter.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 14/09/23.
//

import UIKit

protocol ListOfMoviesRouterProtocol: AnyObject {
    var detailRouter: DetailMovieRouterProtocol? { get }
    var listOfMoviesView: ListOfMoviesViewController? { get }
    
    func showListOfMovies(window: UIWindow?)
    func showDetailMovie(withMovieId movieId: String)
}

final class ListOfMoviesRouter: ListOfMoviesRouterProtocol {
    var detailRouter: DetailMovieRouterProtocol?
    var listOfMoviesView: ListOfMoviesViewController?
    
    func showListOfMovies(window: UIWindow?) {
        self.detailRouter = DetailMovieRouter()
        let interactor = ListOfMoviesInteractor()
        let presenter = ListOfMoviesPresenter(listOfMoviesInteractor: interactor,
                                              listOfMoviesRouter: self)
        
        listOfMoviesView = ListOfMoviesViewController(presenter: presenter)
        
        presenter.view = listOfMoviesView
        
        window?.rootViewController = listOfMoviesView
        window?.makeKeyAndVisible()
    }
    
    func showDetailMovie(withMovieId movieId: String) {
        guard let viewController = listOfMoviesView else { return }
        detailRouter?.showDetail(fromViewController: viewController, movieId: movieId)
    }
}
