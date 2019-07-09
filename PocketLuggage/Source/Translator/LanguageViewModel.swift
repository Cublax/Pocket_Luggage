//
//  LanguageViewModel.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 04/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class LanguageViewModel {
    
    // MARK: Private properties
    
    private weak var delegate: LanguageViewControllerDelegate?

    private var languageItems: [LanguageItem] = [] {
        didSet {
            let items = languageItems.map { Item(languageItem: $0) }
            visibleItems?(items)
        }
    }
    
    private let repository: LanguageRepositoryType
    
    // MARK: - Initializer
    
    init(delegate: LanguageViewControllerDelegate, repository: LanguageRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Properties
    
    enum Item: Equatable {
        case language(text: String, state: Bool)
    }
    
    fileprivate enum LanguageItem: Equatable {
        case language(name: String, atribute: String, state: Bool)
    }
    
    private class func initialItems(from languages: [Language]) -> [LanguageItem] {
        return languages.map {
            return .language(name: $0.title, atribute: $0.key, state: false)
        }
    }
    
    // MARK: - Outputs
    
    var titleText: ((String) -> Void)?
    
    var visibleItems: (([Item]) -> Void)?
    
    // MARK: - Inputs
    
      func viewDidLoad() {
        titleText?("Languages")
        repository.requestLanguages { [weak self] (languages) in
            self?.languageItems = LanguageViewModel.initialItems(from: languages)
        }
    }
    
    func didSelectItem(at index: Int) {
        /// On vera plus tard
    }
}

extension LanguageViewModel.Item {
    fileprivate init(languageItem: LanguageViewModel.LanguageItem) {
        switch languageItem {
        case .language(name: let name, atribute: _, state: let state) :
            self = .language(text: name, state: state)
        }
    }
}
