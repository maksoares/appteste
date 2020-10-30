//
//  MainCoordinator.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var parent: Coordinator? { get set }
    func start()
}

public extension Coordinator {
    func add(_ child: Coordinator) {
        children.append(child)
        child.parent = self
    }

    func remove(_ child: Coordinator) {
        children.removeAll { $0 === child }
    }
}


class MainCoordinator: Coordinator {
    
    // MARK: Attributes
    public var children = [Coordinator]()
    var navigationController : UINavigationController
    weak public var parent: Coordinator?
    
    // MARK: Initalizers
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController!
    }
    
    func start() {
        let vc = MoviesViewController()
        vc.coordinator =  self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func movieDetail(movieId: String) {
        let vc = MovieDetailViewController(movieId: movieId)
        vc.coordinator =  self
        navigationController.pushViewController(vc, animated: true)
    }

    func book(movieId: String) {
        let vc = BookViewController(movieId: movieId)
        vc.coordinator =  self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func shareMovieDetailActivityViewController(viewController: UIViewController, message: String, movieId: String) {
        
        var shareInfo = [Any]()
        shareInfo.append(message)
        
        let str = DeeplinkParser.SCHEME + DeeplinkParser.MOVIE_DETAIL + "/" + movieId
        if let url = NSURL(string: str) {
            shareInfo.append(url)
        }

        let activityViewController = UIActivityViewController(activityItems: shareInfo, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        viewController.present(activityViewController, animated: true, completion: nil)
                
    }
    
}
