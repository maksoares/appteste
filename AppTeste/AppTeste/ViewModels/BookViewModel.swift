//
//  BookViewModel.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class BookViewModel {
    
    // MARK: - Properties
    let nameError = PublishSubject<String>()
    let emailError = PublishSubject<String>()
    let book = PublishSubject<Bool>()
    let loading = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    

    //MARK: Movies
    func book(movieId: String, name: String, email: String) {
        
        if name.count == 0 {
            self.nameError.onNext(NSLocalizedString("Invalid name!", comment: ""))
            return
        }
        
        if !CustomFunctions().isValidEmail(email: email) {
            self.emailError.onNext(NSLocalizedString("Invalid e-mail!", comment: ""))
            return
        }

        let parameters: [String: Any] = [
            "movieId": movieId,
            "name": name,
            "email": email
        ]
        
        loading.onNext(true)
        ServiceManager().book(parameters: parameters) { (messageError, bookResponse) in
            self.loading.onNext(false)
            self.book.onNext(messageError == nil)
        }
    }
    
}
