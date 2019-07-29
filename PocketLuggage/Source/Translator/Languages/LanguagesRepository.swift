//
//  LanguagesRepository.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 08/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation
import SwiftGoogleTranslate

struct Language {
    let key: String
    let title: String
}

protocol LanguageRepositoryType: class {
    func requestLanguages(callback: @escaping ([Language]) -> Void)
}

final class LanguageRepository: LanguageRepositoryType {
    
      // MARK: - Properties
    
    private var translator: SwiftGoogleTranslate

     // MARK: - Initializer
    
    init() {
        translator = SwiftGoogleTranslate.shared
        translator.start(with: "AIzaSyC5G9jKEyehau2iR0MfAe1WD6_a3cqNHEI")
    }
    
    // MARK: - Requests
    
    func requestLanguages(callback: @escaping ([Language]) -> Void) {
        translator.languages { (languages, error) in
            guard let languages = languages else { return }
            let result = languages.map { Language(key: $0.language, title: $0.name) }
            callback(result)
        }
    }
}
