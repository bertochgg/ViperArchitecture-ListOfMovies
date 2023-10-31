//
//  ListOfMoviesPresenter.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 14/09/23.
//

import Foundation

protocol ListOfMoviesPresenterDelegate: AnyObject {
    func update(movies: [PopularMovieViewModel])
}

protocol ListOfMoviesPresenterProtocol: AnyObject {
    var view: ListOfMoviesPresenterDelegate? { get }
    func OnViewAppear()
    var movieViewModels: [PopularMovieViewModel] { get }
    func onTapCell(atIndex: Int)
}

final class ListOfMoviesPresenter: ListOfMoviesPresenterProtocol {
    weak var view: ListOfMoviesPresenterDelegate?
    private let listOfMoviesInteractor: ListOfMoviesInteractorProtocol
    private let listOfMoviesRouter: ListOfMoviesRouterProtocol
    private let mapper: PopularMovieMapper
    
    var movieViewModels: [PopularMovieViewModel] = []
    var movieModels: [Result] = []
    
    init(listOfMoviesInteractor: ListOfMoviesInteractorProtocol,
         mapper: PopularMovieMapper = PopularMovieMapper(),
         listOfMoviesRouter: ListOfMoviesRouterProtocol) {
        self.listOfMoviesInteractor = listOfMoviesInteractor
        self.listOfMoviesRouter = listOfMoviesRouter
        self.mapper = mapper
    }

    func OnViewAppear() {
        Task {
            movieModels = await listOfMoviesInteractor.getListOfMovies().results
            movieViewModels = movieModels.map(mapper.map(entity:))
            view?.update(movies: movieViewModels)
        }
    }
    
    func onTapCell(atIndex: Int) {
        let movieId = movieModels[atIndex].id
        listOfMoviesRouter.showDetailMovie(withMovieId: movieId.description)
    }
    
}
