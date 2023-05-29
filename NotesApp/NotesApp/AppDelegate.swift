//
//  AppDelegate.swift
//  NotesApp
//
//  Created by Азалия Халилова on 19.05.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window {
            let navigationController = UINavigationController()
            let viewController = NotesListViewController()
            viewController.viewModel = NotesListViewModel()
            navigationController.viewControllers = [viewController]
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        return true
    }
}
