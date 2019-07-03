//
//  TranslatorRepository.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation
import SwiftGoogleTranslate

protocol TranslatorRepositoryType: class {
    func translateRequest(for text: String,
                          from originLanguage: String,
                          to destinationLanguage: String,
                          callback: @escaping ((String?, Error?) -> Void))
}

final class TranslatorRepository: TranslatorRepositoryType {
    
    // MARK: - Properties
    
    private var translator: SwiftGoogleTranslate
    
    // MARK: - Initializer
    
    init() {
        translator = SwiftGoogleTranslate.shared
        translator.start(with: "AIzaSyC5G9jKEyehau2iR0MfAe1WD6_a3cqNHEI")
    }
    
    // MARK: - Requests
    
    func translateRequest(for text: String,
                          from originLanguage: String,
                          to destinationLanguage: String,
                          callback: @escaping ((String?, Error?) -> Void)) {
        translator.translate(text, destinationLanguage, originLanguage) { (text, error) in
            callback(text, error)
        }
    }
}
