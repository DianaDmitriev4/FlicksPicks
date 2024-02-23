//
//  AppDelegate.swift
//  FlicksPicks
//
//  Created by User on 31.12.2023.
//

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistence stores: \(error)")
            }
        }
        return container
    }()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBar = TabBar()
        if let window {
            window.rootViewController = UINavigationController(rootViewController: tabBar)
            window.makeKeyAndVisible()
        }
        return true
    }
}
