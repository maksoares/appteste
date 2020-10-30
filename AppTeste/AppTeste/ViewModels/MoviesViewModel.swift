//
//  MoviesViewModel.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class MoviesViewModel {
    
    // MARK: - Properties
    let movies = PublishSubject<[Movie]>()
    let error = PublishSubject<String>()
    let loading = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    

    //MARK: Movies
    func loadMovies() {

        loading.onNext(true)
        ServiceManager().loadMovies() { (errorMessage, moviesResponse) in
            self.loading.onNext(false)
            
            if let moviesResponse = moviesResponse {
                self.movies.onNext(moviesResponse)
            } else {
                self.error.onNext(errorMessage ?? NSLocalizedString("Failed to load movies", comment: ""))
            }
        }
    }
    
}
