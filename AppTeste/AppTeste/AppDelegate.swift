//
//  AppDelegate.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//


import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        let nav = UINavigationController()
        let coordinator = MainCoordinator(navigationController: nav)
        coordinator.start()

        window = UIWindow()
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
    
    // MARK: Deeplinks
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
       return DeepLinkManager().handleDeeplink(url: url)
    }
    // MARK: Universal Links
    private func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
       if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
          if let url = userActivity.webpageURL {
             return DeepLinkManager().handleDeeplink(url: url)
          }
       }
       return false
    }
    
}





