//
//  DeeplinkManager.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit

enum DeeplinkType {
    
    enum Content {
        case root
        case details(id: String)
    }
    
    case movies
    case movieDetail(id: String)
    case book(id: String)
}


class DeeplinkNavigator {
    static let shared = DeeplinkNavigator()
    private init() { }
    
    func proceedToDeeplink(_ type: DeeplinkType) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let nav = appDelegate.window?.rootViewController as? UINavigationController else {
            return
        }
        
        nav.popToRootViewController(animated: false)
        let topViewController = nav.topViewController as? MoviesViewController
        
        switch type {
        case .movies:
            topViewController?.coordinator?.finish()
            
        case .movieDetail(id: let id):
            topViewController?.coordinator?.movieDetail(movieId: id)
            
        case .book(id: let id):
            topViewController?.coordinator?.book(movieId: id)
        }
        
    }
    
}


public class DeepLinkManager {
    init() {}
    private var deeplinkType: DeeplinkType?

    
    @discardableResult
    func handleDeeplink(url: URL) -> Bool {
        deeplinkType = DeeplinkParser.shared.parseDeepLink(url)
        
        if let deeplinkType = deeplinkType {
            DeeplinkNavigator.shared.proceedToDeeplink(deeplinkType)
        }
        
        return deeplinkType != nil
    }
    
    func checkDeepLink() {
        guard let deeplinkType = deeplinkType else {
            return
        }
        
        DeeplinkNavigator.shared.proceedToDeeplink(deeplinkType)
        self.deeplinkType = nil
    }
}



class DeeplinkParser {
    static let shared = DeeplinkParser()
    init() { }
    
    //MARK
    static let SCHEME = "appteste://"
    
    static let MOVIES = "movies"
    static let MOVIE_DETAIL = "movieDetail"
    static let BOOK = "book"
    
    func parseDeepLink(_ url: URL) -> DeeplinkType? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = components.host else {
            return nil
        }
        var pathComponents = components.path.components(separatedBy: "/")
        
        pathComponents.removeFirst()
        switch host {
        case DeeplinkParser.MOVIES:
            return DeeplinkType.movies
        case DeeplinkParser.MOVIE_DETAIL:
            if let requestId = pathComponents.first {
                return DeeplinkType.movieDetail(id: requestId)
            }
        case DeeplinkParser.BOOK:
            if let requestId = pathComponents.first {
                return DeeplinkType.book(id: requestId)
            }
        default:
            break
        }
        return nil
    }
    
}
