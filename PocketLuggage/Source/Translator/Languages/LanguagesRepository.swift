//
//  LanguagesRepository.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 08/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

struct Language {
    let key: String
    let title: String
}

protocol LanguageRepositoryType: class {
    func requestLanguages(callback: @escaping ([Language]) -> Void)
}

final class LanguageRepository: LanguageRepositoryType {
    
    let languages: [String: String] = [
        "fr" : "français",
        "de" : "deutsch",
    ]
    
    func requestLanguages(callback: @escaping ([Language]) -> Void) {
        callback(languages.map { (key, value) -> Language in
            return Language(key: key, title: value)
        })
    }
}
