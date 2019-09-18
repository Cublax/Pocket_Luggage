//
//  ConverterRepository.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 29/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol ConverterRepositoryType: class {
    func getCurrenciesRate(completion: @escaping (CurrencyItem) -> Void)
    func getCurenciesList(completion: @escaping (SymbolsItem) -> Void)
}

final class ConverterRepository: ConverterRepositoryType {
    
    // MARK: - Properties
  
    private let client: HTTPClient
    
    private let token = RequestCancellationToken()
    
    init() {
        self.client = HTTPClient(cancellationToken: token)
    }
    
    // MARK: - Requests
    
    func getCurrenciesRate(completion: @escaping (CurrencyItem) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=bc44d0b411a56c92c53f0b0962be3a0f&base=EUR") else { return }
        
        client.request(type: Currency.self, requestType: .GET, url: url) { (response) in
            let item: CurrencyItem = CurrencyItem(updatedDate: response.date,
                                                  rates: response.rates)
            completion(item)
        }
    }
    
    func getCurenciesList(completion: @escaping (SymbolsItem) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/symbols?access_key=bc44d0b411a56c92c53f0b0962be3a0f") else { return }
        
        client.request(type: Symbols.self, requestType: .GET, url: url) { (response) in
            let item: SymbolsItem = SymbolsItem(symbols: response.symbols)
            completion(item)
        }
    }
}
