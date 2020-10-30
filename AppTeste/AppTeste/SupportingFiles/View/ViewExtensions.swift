//
//  ViewExtensions.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit
import RxSwift
import CoreLocation
import Nuke

extension UIAlertController {
    
    class func customAlertController(title: String, message : String, tryAgain : Bool = false, completion: @escaping (Bool) -> ()  = { _ in } ) -> UIAlertController{
        
        let alertController = UIAlertController(title: title, message: "\n\(message)", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel){ (action:UIAlertAction) in
            completion(false)
        }
        alertController.addAction(cancelAction)
        
        if tryAgain {
            let reloadAction = UIAlertAction(title: NSLocalizedString("Try again", comment: ""), style: .default) { (action:UIAlertAction) in
                completion(true)
            }
            alertController.addAction(reloadAction)
        }
        
        return alertController
    }
}


extension UIViewController {
    
    func showActivityIndicator(loading: Bool, activityIndicatorView: UIActivityIndicatorView){
        
        activityIndicatorView.isHidden = !loading
        loading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = !loading
        navigationItem.leftBarButtonItem?.isEnabled = !loading
    }
    
    func configureNavigationBar(title: String, buttonSystemType: UIBarButtonItem.SystemItem, disposeBag: DisposeBag, completion: @escaping()-> Void) {
        
        navigationItem.title = title
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: buttonSystemType, target: self, action: nil)
        barButtonItem.rx.tap
            .subscribe(onNext: {
                completion()
            })
            .disposed(by: disposeBag)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

public extension UIImageView {
    
    func loadImageFromString(url: String?, completion: ((Image?) -> Void)? = nil) {
        
        guard let url = URL(string: url ?? "") else {
            completion?(UIImage(named: "noImage") ?? nil)
            return
        }
        
        let options = ImageLoadingOptions(placeholder: nil, transition: .fadeIn(duration: 0.33))
        Nuke.loadImage(with: url, options: options, into: self, completion: {imageResponse, error  in
            if let image = imageResponse?.image {
                completion?(image)
            } else {
                self.image = UIImage(named: "noImage")
                completion?(UIImage(named: "noImage") ?? nil)
            }
        })
        
    }
    
}

extension UIView {
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var topConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .top && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var bottomConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .bottom && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    
    
    
}


extension NSLayoutAnchor {
    @objc func constraintEqualToAnchor(anchor: NSLayoutAnchor!, constant:CGFloat, identifier:String) -> NSLayoutConstraint! {
        let constraint = self.constraint(equalTo: anchor, constant:constant)
        constraint.identifier = identifier
        return constraint
    }
}



extension NSLayoutConstraint {

    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

}


public extension Reactive where Base: UIImageView {
    var isEmpty: Observable<Bool> {
        return observe(UIImage.self, "image").map{ $0 == nil }
    }
}
