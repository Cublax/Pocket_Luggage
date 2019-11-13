//
//  ConverterRepository.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 29/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol ConverterRepositoryType: class {
    func getCurrenciesRate(success: @escaping (CurrencyItem) -> Void, failure: @escaping (() -> Void))
    func getCurenciesList(success: @escaping (SymbolsItem) -> Void, failure: @escaping (() -> Void))
}

final class ConverterRepository: ConverterRepositoryType {
    
    private let networkClient: HTTPClient

    private let urlRequestBuilder = URLRequestBuilder()

    private let cancellationToken = RequestCancellationToken()

    // MARK: - Init

    init(networkClient: HTTPClient) {
        self.networkClient = networkClient
    }
    // MARK: - Requests
    
     func getCurrenciesRate(success: @escaping (CurrencyItem) -> Void, failure: @escaping (() -> Void)) {
        
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=bc44d0b411a56c92c53f0b0962be3a0f&base=EUR") else { return }
        
         let urlRequest = URLRequest(url: url)

               networkClient
                   .executeTask(urlRequest, cancelledBy: cancellationToken)
                   .processCodableResponse { (response: HTTPResponse<CurrencyItem>) in
                       switch response.result {
                       case .success(let currencyResponse):
                        success(currencyResponse)
                       case .failure(_):
                           failure()
                       }
               }
           }
    
    
   func getCurenciesList(success: @escaping (SymbolsItem) -> Void, failure: @escaping (() -> Void)) {
     
        guard let url = URL(string: "http://data.fixer.io/api/symbols?access_key=bc44d0b411a56c92c53f0b0962be3a0f") else { return }
           
        let urlRequest = URLRequest(url: url)
    
            networkClient
                .executeTask(urlRequest, cancelledBy: cancellationToken)
                .processCodableResponse { (response: HTTPResponse<SymbolsItem>) in
                    switch response.result {
                    case .success(let symbolsResponse):
                        success(symbolsResponse)
                    case .failure(_):
                        failure()
                    }
            }
        }
}


