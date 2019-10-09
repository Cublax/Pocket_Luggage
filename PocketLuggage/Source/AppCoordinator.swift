//
//  AppCoordinator.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Properties
    
    private unowned var appDelegate: AppDelegate
    
    private var tabCoordinator: TabCoordinator?
    
    // MARK: - Initializer
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    // MARK: - Coordinator
    
    func start() {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.rootViewController = UIViewController()
        appDelegate.window!.makeKeyAndVisible()
        
        tabCoordinator = TabCoordinator(presenter: appDelegate.window!)
        tabCoordinator?.start()
    }
}
