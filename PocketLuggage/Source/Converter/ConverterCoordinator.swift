//
//  ConverterCoordinator.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class ConverterCoordinator {
    
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
        showConverter()
    }
    
    private func showConverter() {
        let viewController = screens.createConverterViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    func showAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension ConverterCoordinator: ConverterViewModelDelegate {
    func shouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }
}
