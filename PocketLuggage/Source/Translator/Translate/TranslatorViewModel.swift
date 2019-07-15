//
//  TranslatorViewModel.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol TranslatorViewModelDelegate: class {
    func didPresentLanguages(for type: LanguageViewType)
    func ShouldDisplayAlert(for type: AlertType)
}

struct LanguageCOnfiguration {
    var originLanguage: (name: String, attribute: String)
    var destinationLanguage: (name: String, attribute: String)
}

enum LanguageViewType {
    case origin
    case destination
}

final class TranslatorViewModel {
    
    // MARK: - Properties
    
    private let repository: TranslatorRepositoryType
    
    private let languageConfiguration: LanguageCOnfiguration
    
    private weak var delegate: TranslatorViewModelDelegate?
    
    // MARK: - Initializer
    
    init(repository: TranslatorRepository,
         languageConfiguration: LanguageCOnfiguration,
         delegate: TranslatorViewModelDelegate?) {
        self.repository = repository
        self.languageConfiguration = languageConfiguration
        self.delegate = delegate
    }
    
    // MARK: - Outputs
    
    var originTextLanguague: ((String) -> Void)?
    
    var destinationTextLanguage: ((String) -> Void)?
    
    var traductedText: ((String) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        originTextLanguague?(languageConfiguration.originLanguage.name)
        destinationTextLanguage?(languageConfiguration.destinationLanguage.name)
    }
    
    func didSelectLang(for type: LanguageViewType) {
        delegate?.didPresentLanguages(for: type)
    }
    
    
    func didPressTranslate(for text: String) {
        repository.translateRequest(for: text,
                                    from: languageConfiguration.originLanguage.attribute,
                                    to: languageConfiguration.destinationLanguage.attribute) { [weak self] (text, error) in
            if let text = text {
                self?.traductedText?(text)
            } else if error != nil {
                self?.delegate?.ShouldDisplayAlert(for: .translationError)
            }
        }
    }
}
