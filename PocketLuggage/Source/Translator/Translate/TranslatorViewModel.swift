//
//  TranslatorViewModel.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol TranslatorViewModelDelegate: class {
    func didPresentLanguages()
}

final class TranslatorViewModel {
    
    // MARK: - Properties
    
    private let repository: TranslatorRepositoryType
    
    private weak var delegate: TranslatorViewModelDelegate?
    
    // MARK: - Initializer
    
    init(repository: TranslatorRepository, delegate: TranslatorViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Outputs
    
    var traductedText: ((String) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        
    }
    
    func didSelectLangForItem(at index: Int) {
        delegate?.didPresentLanguages()
    }
    
    func didPressTranslate(for text: String, from: String, to: String) {
        repository.translateRequest(for: text, from: from, to: to) { [weak self] (text, error) in
            if let text = text {
                self?.traductedText?(text)
            } else if let error = error {
                // Du code pour dire au coordinatpr d'afficher une alert : appeler un delegate
            }
        }
    }
}
