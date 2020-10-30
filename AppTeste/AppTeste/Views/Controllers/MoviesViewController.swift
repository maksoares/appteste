//
//  MoviesViewController.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    var coordinator: MainCoordinator?
    var viewModel: MoviesViewModel = MoviesViewModel()
    var customView = MoviesView()

    // MARK: - Private
    private let disposeBag = DisposeBag()
    
    
    // MARK: - UIViewController
    override func loadView() {
        view = customView
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupBinds()
        viewModel.loadMovies()
    }
    
    
    // MARK: - Binds
    private func setupBinds() {
        
        //TableView
        customView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        customView.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.REUSE_IDENTIFIER)
        
        viewModel.movies.bind(to: customView.tableView.rx.items(cellIdentifier: MovieTableViewCell.REUSE_IDENTIFIER, cellType: MovieTableViewCell.self)) {
            (row,movie,cell) in
            cell.movie = movie
        }.disposed(by: disposeBag)
        customView.tableView.rx.modelSelected(Movie.self).subscribe(onNext: { movie in
            
            self.coordinator?.movieDetail(movieId: movie.movieId ?? "")
            
        }).disposed(by: disposeBag)
        
        
        //Error
        viewModel.error.subscribe({ (messageError) in
            let alertController = UIAlertController.customAlertController(title: NSLocalizedString("Error", comment: ""), message: messageError.element ?? "", tryAgain: true){ tryAgain in
                if tryAgain {(self.viewModel.loadMovies())}
            }
            self.present(alertController, animated: true, completion: nil)
        })
        .disposed(by: disposeBag)
        
        // Loading
        viewModel.loading.subscribe(onNext: { (isLoading) in
            self.showActivityIndicator(loading: isLoading, activityIndicatorView: self.customView.activityIndicatorView)
        })
        .disposed(by: disposeBag)

    }

    // MARK: - Interface
    func configureView() {
        
        //Navigation Bar
        configureNavigationBar(title: NSLocalizedString("Movies", comment: ""), buttonSystemType: .refresh, disposeBag: disposeBag){
            self.viewModel.loadMovies()
        }
        
        //TableView
        customView.tableView.contentInset = UIEdgeInsets(top: Spacing.TOP, left: 0, bottom: Spacing.BOTTOM, right: 0)
        
    }
    
}
