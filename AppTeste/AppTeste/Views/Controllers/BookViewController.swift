//
//  BookViewController.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import RxSwift
import RxCocoa

class BookViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    var coordinator: MainCoordinator?
    var viewModel: BookViewModel = BookViewModel()
    var customView = BookView()

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
    }
    
    // MARK: - Binds
    private func setupBinds() {
        
        // Book
        customView
            .bookButton
            .rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.book(movieId: self.movieId, name: self.customView.nameTextView.text,
                                       email: self.customView.emailTextView.text)
            }).disposed(by: disposeBag)

        
        //Name
        viewModel.nameError.subscribe({ (message) in
            let alert = UIAlertController.customAlertController(title: NSLocalizedString("Error", comment: ""),
                                                                message: message.element ?? ""){ _ in
                self.customView.nameTextView.becomeFirstResponder()
            }
            self.present(alert, animated: true, completion: nil)
        })
        .disposed(by: disposeBag)
        
        //Email
        viewModel.emailError.subscribe({ (message) in
            let alert = UIAlertController.customAlertController(title: NSLocalizedString("Error", comment: ""),
                                                                message: message.element ?? ""){ _ in
                self.customView.emailTextView.becomeFirstResponder()
            }
            self.present(alert, animated: true, completion: nil)
        })
        .disposed(by: disposeBag)
        
        //Book
        viewModel.book.subscribe(onNext: { (book) in

            if book {
                let alert = UIAlertController.customAlertController(
                    title: NSLocalizedString("Alert", comment: ""),
                    message: NSLocalizedString("Successful book", comment: "")){ _ in
                    self.coordinator?.finish()
                }
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController.customAlertController(
                    title: NSLocalizedString("Error", comment: ""),
                    message: NSLocalizedString("Failed to book", comment: ""), tryAgain: true){ tryAgain in
                    if tryAgain {
                        self.viewModel.book(movieId: self.movieId, name: self.customView.nameTextView.text, email: self.customView.emailTextView.text)
                    }
                }
                self.present(alert, animated: true, completion: nil)
            }
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
        //NavigationBar
        navigationItem.title = NSLocalizedString("Book", comment: "")
        
        hideKeyboardWhenTappedAround()
        
        customView.nameTextView.becomeFirstResponder()
    }
    
}
