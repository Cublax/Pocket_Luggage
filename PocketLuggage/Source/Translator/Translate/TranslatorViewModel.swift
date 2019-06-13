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
    
    init(repository: TranslatorRepositoryType, delegate: TranslatorViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Outputs
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        
    }
    
    func didSelectLangForItem(at index: Int) {
        delegate?.didPresentLanguages()
    }
}
