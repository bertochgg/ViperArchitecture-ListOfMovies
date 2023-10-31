//
//  ListOfMoviesViewController.swift
//  ArchitectureViper
//
//  Created by Cesar Humberto Grifaldo Garcia on 14/09/23.
//

import UIKit

final class ListOfMoviesViewController: UIViewController {
    private let presenter: ListOfMoviesPresenterProtocol
    private let dataSource: ListOfMoviesDataSourceProtocol = ListOfMoviesDataSource()
    
    lazy private var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieViewCell.self, forCellReuseIdentifier: MovieViewCell.identifier)
        return tableView
    }()
    
    init(presenter: ListOfMoviesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        presenter.OnViewAppear()
        self.setupTableView()
        
    }
    
    private func setupTableView() {
        view.addSubview(moviesTableView)
        
        NSLayoutConstraint.activate([
            moviesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        moviesTableView.dataSource = dataSource
        moviesTableView.delegate = self
    }
}

extension ListOfMoviesViewController: ListOfMoviesPresenterDelegate {
    func update(movies: [PopularMovieViewModel]) {
        print(movies)
        DispatchQueue.main.async {
            self.dataSource.updateData(with: movies)
            self.moviesTableView.reloadData()
        }
    }
}

extension ListOfMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(atIndex: indexPath.row)
    }
}
