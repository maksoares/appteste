//
//  MovieDetailViewController.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import RxSwift
import RxCocoa
import Nuke

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    var coordinator: MainCoordinator?
    var viewModel: MovieDetailViewModel = MovieDetailViewModel()
    var customView = MovieDetailView()
    

    // MARK: - Private
    private let disposeBag = DisposeBag()
    private var movieId = ""
    
    convenience init(movieId: String) {
        self.init()
        self.movieId = movieId
    }
    
    // MARK: - UIViewController
    override func loadView() {
        view = customView
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupBinds()
        viewModel.loadMovieDetail(movieId: movieId)
    }
    
    
    // MARK: - Binds
    private func setupBinds() {

        //TableView
        customView.tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.REUSE_IDENTIFIER)
        customView.tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.REUSE_IDENTIFIER)
        customView.tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.REUSE_IDENTIFIER)
        customView.tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.REUSE_IDENTIFIER)
        customView.tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.REUSE_IDENTIFIER)
        
        viewModel.tableViewCells.bind(to: customView.tableView.rx.items){ (tv,row,contentCell )  -> UITableViewCell in
            return self.configureCell(tv: tv, row: row, contentCell: contentCell)
        }.disposed(by: disposeBag)
        
        
        
        //Error
        viewModel.error.subscribe({ (messageError) in
            let alertController = UIAlertController.customAlertController(title: NSLocalizedString("Error", comment: ""), message: messageError.element ?? "", tryAgain: true){ tryAgain in
                tryAgain ? (self.viewModel.loadMovieDetail(movieId: self.movieId)) : self.coordinator?.finish()
            }
            self.present(alertController, animated: true, completion: nil)
        })
        .disposed(by: disposeBag)
        
        
        // Loading
        viewModel.loading.subscribe(onNext: { (isLoading) in
            self.customView.activityIndicatorView.isHidden = !isLoading
            isLoading ? self.customView.activityIndicatorView.startAnimating() : self.customView.activityIndicatorView.stopAnimating()
        })
        .disposed(by: disposeBag)

    }
    
    // MARK: - Interface
    func configureView() {
        
        //Navigation Bar
        configureNavigationBar(title: NSLocalizedString("Details", comment: ""), buttonSystemType: .action, disposeBag: disposeBag){
            self.coordinator?.shareMovieDetailActivityViewController(viewController: self, message: self.viewModel.shareText, movieId: self.movieId)
        }

    }
}


extension MovieDetailViewController {
    
    // MARK: - TableView
    func configureCell(tv: UITableView, row: Int, contentCell: ContentTableViewCell) -> UITableViewCell {
        
        switch contentCell.type {
        
        case .title:
            
            let cell = tv.dequeueReusableCell(withIdentifier: TextTableViewCell.REUSE_IDENTIFIER, for: IndexPath.init(row: row, section: 0)) as! TextTableViewCell
            cell.titleLabel.font = Consts.DETAIL_TITLE_FONT
            cell.titleLabel.textAlignment = .center
            if let string = contentCell.value as? String {
                cell.string = string
                return cell
            }
            return UITableViewCell()
            
        case .image:
            
            let cell = tv.dequeueReusableCell(withIdentifier: ImageTableViewCell.REUSE_IDENTIFIER, for: IndexPath.init(row: row, section: 0)) as! ImageTableViewCell
            if let string = contentCell.value as? String {
                cell.imageUrl = string
                return cell
            }
            return UITableViewCell()
            
        case .description:
            
            let cell = tv.dequeueReusableCell(withIdentifier: TextTableViewCell.REUSE_IDENTIFIER, for: IndexPath.init(row: row, section: 0)) as! TextTableViewCell
            if let string = contentCell.value as? String {
                cell.string = string
                return cell
            }
            return UITableViewCell()
            
        case .info:
            
            let cell = tv.dequeueReusableCell(withIdentifier: InfoTableViewCell.REUSE_IDENTIFIER, for: IndexPath.init(row: row, section: 0)) as! InfoTableViewCell
            if let movie = contentCell.value as? Movie {
                cell.movie = movie
                return cell
            }
            return UITableViewCell()
            
        case .collectionView:
            let cell = tv.dequeueReusableCell(withIdentifier: CollectionTableViewCell.REUSE_IDENTIFIER, for: IndexPath.init(row: row, section: 0)) as! CollectionTableViewCell
            if let people = contentCell.value as? [Movie.Person] {
                cell.people = people
                return cell
            }
            return UITableViewCell()
            
        case .button:
            let cell = tv.dequeueReusableCell(withIdentifier: ButtonTableViewCell.REUSE_IDENTIFIER, for: IndexPath.init(row: row, section: 0)) as! ButtonTableViewCell
            
            if let string = contentCell.value as? String {
                cell.string = string
                cell.button.rx.tap
                    .bind { [weak self] _ -> Void in
                        self?.coordinator?.book(movieId: self?.movieId ?? "")
                    }
                    .disposed(by: cell.disposeBag)
                
                return cell
            }
            return UITableViewCell()

        }

    }

}
 


/* TableViewExample

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView(){
        
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.REUSE_IDENTIFIER)
        customView.tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.REUSE_IDENTIFIER)
        customView.tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.REUSE_IDENTIFIER)
        customView.tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.REUSE_IDENTIFIER)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    // create a cell for each table view row
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.configureCell(tv: tableView, row: indexPath.row, type: viewModel.cells[indexPath.row])
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
}

 */
