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

protocol LanguageViewControllerDelegate: class {
    func languageScreenDidSelectDetail(with title: String)
}

extension Screens {
    func createTranslatorViewController(delegate: TranslatorViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "TranslatorViewController") as! TranslatorViewController
        let repository = TranslatorRepository()
        let viewModel = TranslatorViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createLanguagesViewController(delegate: LanguageViewControllerDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LanguagesViewController") as! LanguagesViewController
        let repository = LanguageRepository()
        let viewModel = LanguageViewModel(delegate: delegate!, repository: repository)
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

