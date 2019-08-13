//
//  LanguageViewModel.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 04/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol LanguageViewModelDelegate: class {
    func languageScreenDidSelectDetail(with language: LanguageType)
}

struct LanguageStruct: Equatable {
    let name: String
    let atribute: String
}

final class LanguageViewModel {
    
    // MARK: Private properties
    
    private weak var delegate: LanguageViewModelDelegate?

    private var languageItems: [LanguageItem] = [] {
        didSet {
            let items = languageItems.map { Item(languageItem: $0) }
            visibleItems?(items)
        }
    }
    
    private let repository: LanguageRepositoryType
    
    private let languageType: LanguageViewType
    
    // MARK: - Initializer
    
    init(languageType: LanguageViewType,
         repository: LanguageRepositoryType,
         delegate: LanguageViewModelDelegate?) {
        self.languageType = languageType
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Properties
    
    enum Item: Equatable {
        case language(text: String)
    }
    
    fileprivate enum LanguageItem: Equatable {
        case language(languageStruct: LanguageStruct)
    }
    
    private class func initialItems(from languages: [Language]) -> [LanguageItem] {
        return languages.map {
            return .language(languageStruct: LanguageStruct(name: $0.title,
                                                            atribute: $0.key))
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
        guard index < languageItems.count else {
            return
        }
        let item = languageItems[index]
        if case .language(languageStruct: let languageStruct) = item {
            switch languageType {
            case .origin:
                delegate?.languageScreenDidSelectDetail(with: .origin(languageStruct.name, languageStruct.atribute))
            case .destination:
                delegate?.languageScreenDidSelectDetail(with: .destination(languageStruct.name, languageStruct.atribute))
            }
    }
    }
}

extension LanguageViewModel.Item {
    fileprivate init(languageItem: LanguageViewModel.LanguageItem) {
        switch languageItem {
        case .language(languageStruct: let languageStruct) :
            self = .language(text: languageStruct.name)
        }
    }
}
