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
    
    private var defaultConfiguration = CurrencyConfiguration(originCurrency: (currencyKey: "EUR", rate: 1, amount: "1"), destinationCurrency: (currencyKey: "USD", rate: 1.12, amount: "1"))
    
    func start() {
        showConverter(with: defaultConfiguration)
    }
    
    private func showConverter(with configuration: CurrencyConfiguration) {
        let viewController = screens.createConverterViewController(with: configuration, delegate: self)
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
