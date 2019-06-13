//
//  TranslatorRepository.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol TranslatorRepositoryType: class {
    
}

final class TranslatorRepository: TranslatorRepositoryType {
    
    // MARK: - Properties
    
    private let network: Network
    
    // MARK: - Initializer
    
    init(network: Network) {
        self.network = network
    }
    
    // MARK: - Requests
    
    //    func requestLang() {
    //        network.request() {
    //
    //        }
    //    }
}
