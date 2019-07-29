//
//  Screens.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class Screens {
    // MARK: - Properties
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
    
}

// MARK: - Translator

extension Screens {
    func createTranslatorViewController(with languageConfiguration: LanguageConfiguration, delegate: TranslatorViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "TranslatorViewController") as! TranslatorViewController
        let repository = TranslatorRepository()
        let viewModel = TranslatorViewModel(repository: repository,
                                            languageConfiguration: languageConfiguration,
                                            delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createLanguagesViewController(languageType: LanguageViewType, delegate: LanguageViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LanguagesViewController") as! LanguagesViewController
        let repository = LanguageRepository()
        let viewModel = LanguageViewModel(languageType: languageType, repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Meteo

extension Screens {
    func createMeteoViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "MeteoViewController") as! MeteoViewController
        return viewController
    }
}

// MARK: - Converter

extension Screens {
    func createConverterViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConverterViewController") as! ConverterViewController
        return viewController
    }
}

// MARK: - Alert

extension Screens {
    func createAlert(for type: AlertType) -> UIAlertController {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}

