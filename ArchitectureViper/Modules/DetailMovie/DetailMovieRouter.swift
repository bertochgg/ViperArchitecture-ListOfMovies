//
//  DetailMovieRouter.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 20/09/23.
//

import UIKit

protocol DetailMovieRouterProtocol: AnyObject {
    func showDetail(fromViewController: UIViewController, movieId: String)
}

final class DetailMovieRouter: DetailMovieRouterProtocol {
    func showDetail(fromViewController: UIViewController,
                    movieId: String) {
        let interactor: DetailMovieInteractorProtocol = DetailMovieInteractor()
        let presenter: DetailMoviePresenterProtocol = DetailMoviePresenter(movieId: movieId,
                                                                           interactor: interactor,
                                                                           mapper: DetailMovieViewModelMapper())
        let view = DetailMovieViewController(presenter: presenter)
        
        presenter.view = view
        
        fromViewController.present(view, animated: true)
    }
}

