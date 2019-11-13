//
//  AppDelegate.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: AppCoordinator!
    var context: Context!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let client = HTTPClient(engine: .urlSession(.default))
        
        context = Context(networkClient: client)
        
        coordinator = AppCoordinator(appDelegate: self, context: context)
        coordinator.start()
        return true
    }
}
