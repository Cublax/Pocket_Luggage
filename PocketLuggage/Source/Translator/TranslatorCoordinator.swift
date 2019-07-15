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
    
    private var defaultConfiguration = LanguageCOnfiguration(originLanguage: ("Francais", "fr"),
                                                             destinationLanguage: ("English", "en"))
    
    func start() {
        showTranslate(with: defaultConfiguration)
    }
    
    private func showTranslate(with configuration: LanguageCOnfiguration) {
        let viewController = screens.createTranslatorViewController(with: configuration, delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    private func showLanguages(with type: LanguageViewType) {
        let viewController = screens.createLanguagesViewController(languageType: type, delegate: self)
        presenter.show(viewController, sender: nil)
    }
    
    private func showAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension TranslatorCoordinator: TranslatorViewModelDelegate {
    func didPresentLanguages(for type: LanguageViewType) {
        showLanguages(with: type)
    }
    
    func ShouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }
}

extension TranslatorCoordinator: LanguageViewControllerDelegate {
    func languageScreenDidSelectDetail(with language: LanguageType) {
        /// Dismiss presenter showLanguage() + add showTranslate() en ayant récupéré les informations de langues choisit (title ?)
        presenter.popViewController(animated: true)
        switch language {
        case .origin(let value, let key):
            defaultConfiguration.originLanguage = (value, key)
        case .destination(let value, let key):
            defaultConfiguration.destinationLanguage = (value, key)
        }
        showTranslate(with: defaultConfiguration)
    }
}

enum LanguageType {
    case origin(_ name: String, _ key: String)
    case destination(_ value: String, _ key: String)
}
