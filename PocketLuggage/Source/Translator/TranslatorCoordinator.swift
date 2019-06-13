//
//  TranslatorCoordinator.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class TranslatorCoordinator {
    
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
        showTranslate()
    }
    
    private func showTranslate() {
        let viewController = screens.createTranslatorViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    private func showLanguages() {
        let viewController = screens.createLanguagesViewController()
        presenter.show(viewController, sender: nil)
    }
}

extension TranslatorCoordinator: TranslatorViewModelDelegate {
    func didPresentLanguages() {
        showLanguages()
}
}
