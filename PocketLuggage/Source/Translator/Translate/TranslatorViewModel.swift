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
    func shouldDisplayAlert(for type: AlertType)
}

struct LanguageConfiguration {
    var originLanguage: (name: String, attribute: String, contentText: String)
    var destinationLanguage: (name: String, attribute: String, contentText: String)
}

enum LanguageViewType {
    case origin
    case destination
}

typealias LanguageStructure = (name: String, attribute: String, contentText: String)

final class TranslatorViewModel {
    
    // MARK: - Properties
    
    private let repository: TranslatorRepositoryType
    
    private let languageConfiguration: LanguageConfiguration
    
    private weak var delegate: TranslatorViewModelDelegate?
    
    private var languageStructures: [LanguageStructure] = [] {
        didSet {
            let origin = self.languageStructures[0]
            originTextLanguague?(origin.name)
            originText?(origin.contentText)
            let destination = self.languageStructures[1]
            destinationTextLanguage?(destination.name)
            destinationText?(destination.contentText)
        }
    }
    
    // MARK: - Initializer
    
    init(repository: TranslatorRepositoryType,
         languageConfiguration: LanguageConfiguration,
         delegate: TranslatorViewModelDelegate?) {
        self.repository = repository
        self.languageConfiguration = languageConfiguration
        self.delegate = delegate
    }
    
    private func initializeLanguageStructure(with configuration: LanguageConfiguration) -> [LanguageStructure] {
        return [LanguageStructure(configuration.originLanguage.name,
                                  configuration.originLanguage.attribute,
                                  configuration.originLanguage.contentText),
                LanguageStructure(configuration.destinationLanguage.name,
                                  configuration.destinationLanguage.attribute,
                                  configuration.destinationLanguage.contentText)]
    }
    
    // MARK: - Outputs
    
    var originTextLanguague: ((String) -> Void)?
    
    var destinationTextLanguage: ((String) -> Void)?
    
    var originText: ((String) -> Void)?
    
    var destinationText: ((String) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        languageStructures = initializeLanguageStructure(with: self.languageConfiguration)
    }
    
    func didSelectLang(for type: LanguageViewType) {
        delegate?.didPresentLanguages(for: type)
    }
    
    func didPressTranslate(for originText: String) {
        repository.translateRequest(for: originText,
                                    from: languageConfiguration.originLanguage.attribute,
                                    to: languageConfiguration.destinationLanguage.attribute) { [weak self] (text, error) in
                                        if let text = text {
                                            self?.languageStructures[0].contentText = originText
                                            self?.languageStructures[1].contentText = text
                                        } else if error != nil {
                                            self?.delegate?.shouldDisplayAlert(for: .translationError)
                                        }
        }
    }
    
    func didPressSwitch(with originText: String?, and destinationText: String?) {
        guard languageStructures.count == 2 else {return}
        
        if let originText = originText {
            languageStructures[0].contentText = originText
        }
        if let destinationText = destinationText {
            languageStructures[1].contentText = destinationText
        }
        languageStructures.swapAt(0, 1)
    }
}
