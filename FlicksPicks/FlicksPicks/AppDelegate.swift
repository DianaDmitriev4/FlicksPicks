//
//  AppDelegate.swift
//  FlicksPicks
//
//  Created by User on 31.12.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window {
            window.rootViewController = UINavigationController(rootViewController: GeneralViewController(viewModel: GeneralViewModel()))
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

