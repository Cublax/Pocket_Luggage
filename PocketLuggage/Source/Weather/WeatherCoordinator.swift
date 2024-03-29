//
//  MeteoCoordinator.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class MeteoCoordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    
    private let screens: Screens
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    
    // MARK: - Coordinator
    
    func start() {
        showMeteo()
    }
    
    private func showMeteo() {
        let viewController = screens.createMeteoViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    func showAlert(for type: AlertType) {
           let alert = screens.createAlert(for: type)
           presenter.visibleViewController?.present(alert, animated: true, completion: nil)
       }
}

extension MeteoCoordinator: MeteoViewModelDelegate {
     func shouldDisplayAlert(for type: AlertType) {
           showAlert(for: type)
       }
}
