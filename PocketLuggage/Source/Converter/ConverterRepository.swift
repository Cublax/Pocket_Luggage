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
    
    private let requestBuilder: PocketLuggageRequestBuilder

    private let urlRequestBuilder = URLRequestBuilder()

    private let cancellationToken = RequestCancellationToken()

    // MARK: - Init

    init(networkClient: HTTPClient, requestBuilder: PocketLuggageRequestBuilder) {
        self.networkClient = networkClient
         self.requestBuilder = requestBuilder
    }
    // MARK: - Requests
    
     func getCurrenciesRate(success: @escaping (CurrencyItem) -> Void, failure: @escaping (() -> Void)) {
        
       let currencyEndpoint = CurrencyEndpoint()
        
        guard
        let httpRequest = self.requestBuilder.buildRequest(for: currencyEndpoint),
        let urlRequest = try? self.urlRequestBuilder.buildURLRequest(from: httpRequest)
                   else { failure() ; return }

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
     
    let currencyEndpoint = SymbolsEndpoint()
     
     guard
     let httpRequest = self.requestBuilder.buildRequest(for: currencyEndpoint),
     let urlRequest = try? self.urlRequestBuilder.buildURLRequest(from: httpRequest)
                else { failure() ; return }

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


