//
//  DetailMoviePresenter.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 20/09/23.
//

import Foundation

protocol DetailMoviePresenterDelegate: AnyObject {
    func updateUI(viewModel: DetailMovieViewModel)
}

protocol DetailMoviePresenterProtocol: AnyObject {
    var view: DetailMoviePresenterDelegate? { get set }
    var movieId: String { get }
    func onViewAppear()
}

final class DetailMoviePresenter: DetailMoviePresenterProtocol {
    weak var view: DetailMoviePresenterDelegate?
    
    let movieId: String
    private let interactor: DetailMovieInteractorProtocol
    private let mapper: DetailMovieViewModelMapper
    
    init(movieId: String,
         interactor: DetailMovieInteractorProtocol,
         mapper: DetailMovieViewModelMapper) {
        self.movieId = movieId
        self.interactor = interactor
        self.mapper = mapper
    }
    
    func onViewAppear() {
        Task {
            await interactor.getDetailMovies(id: movieId) { result in
                switch result {
                case .success(let detailMovieEntity):
                    print(detailMovieEntity)
                    let viewModel = self.mapper.map(entity: detailMovieEntity)
                    self.view?.updateUI(viewModel: viewModel)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
