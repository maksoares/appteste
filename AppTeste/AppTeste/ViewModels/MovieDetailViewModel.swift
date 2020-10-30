//
//  MovieDetailViewModel.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import RxSwift
import RxCocoa


enum UITableViewCellType {
    case title
    case image
    case description
    case info
    case collectionView
    case button
}


struct ContentTableViewCell {
    var type : UITableViewCellType
    var value : Any?
}


class MovieDetailViewModel {
    
    // MARK: - Properties
    let tableViewCells = PublishSubject<[ContentTableViewCell]>()
    let error = PublishSubject<String>()
    let loading = PublishSubject<Bool>()
    let disposeBag = DisposeBag()

    var shareText = ""
    
    
    //MARK: Movie Detail
    func loadMovieDetail(movieId: String) {

        loading.onNext(true)
        ServiceManager().loadMovieDetail(movieId: movieId) { (errorMessage, movieResponse) in
            self.loading.onNext(false)
            
            if let movieResponse = movieResponse {
                
                //Format Share message
                CustomFunctions().formatSharedMsg(movie: movieResponse){ formatedString in
                    self.shareText = formatedString
                }
                
                //Format Table View Contents
                self.formatTableViewContent(movie: movieResponse)
                
            } else {
                self.error.onNext(errorMessage ?? NSLocalizedString("Failed to movie details", comment: ""))
            }
        }
    }
    
    
    func formatTableViewContent(movie: Movie){

        var contentCells = [ContentTableViewCell]()
        
        if let title = movie.title {
            contentCells.append(ContentTableViewCell(type: UITableViewCellType.title, value: title))
        }
        
        if let image = movie.image {
            contentCells.append(ContentTableViewCell(type: UITableViewCellType.image, value: image))
        }
        
        if let synopsis = movie.synopsis {
            contentCells.append(ContentTableViewCell(type: UITableViewCellType.description, value: synopsis))
        }
        
        if let people = movie.people {
            contentCells.append(ContentTableViewCell(type: UITableViewCellType.collectionView, value: people))
        }
        
        contentCells.append(ContentTableViewCell(type: UITableViewCellType.info, value: movie))
        contentCells.append(ContentTableViewCell(type: UITableViewCellType.button, value: NSLocalizedString("Book", comment: "")))
        

        self.tableViewCells.onNext(contentCells)
    }
    
    
    
}
