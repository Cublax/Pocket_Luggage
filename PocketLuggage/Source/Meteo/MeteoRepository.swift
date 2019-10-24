//
//  MeteoRepository.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol MeteoRepositoryType: class {
func getForecastMeteoBerlin(success: @escaping (Weather) -> Void, failure: @escaping (() -> Void))
func getForecastMeteoAnnecy(success: @escaping (Weather) -> Void, failure: @escaping (() -> Void))
}

final class MeteoRepository: MeteoRepositoryType {

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
   
    func getForecastMeteoBerlin(success: @escaping (Weather) -> Void, failure: @escaping (() -> Void)) {
       guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Berlin,de&units=metric&APPID=8ef2b02e2cabd2d7092208a0fb5a7688") else { return }
       
        let urlRequest = URLRequest(url: url)

              networkClient
                  .executeTask(urlRequest, cancelledBy: cancellationToken)
                  .processCodableResponse { (response: HTTPResponse<Weather>) in
                      switch response.result {
                      case .success(let weatherResponse):
                       success(weatherResponse)
                      case .failure(_):
                          failure()
                      }
              }
          }
    
    
    func getForecastMeteoAnnecy(success: @escaping (Weather) -> Void, failure: @escaping (() -> Void)) {
       
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Berlin,de&units=metric&APPID=8ef2b02e2cabd2d7092208a0fb5a7688") else { return }
        
         let urlRequest = URLRequest(url: url)

              networkClient
                  .executeTask(urlRequest, cancelledBy: cancellationToken)
                  .processCodableResponse { (response: HTTPResponse<Weather>) in
                      switch response.result {
                      case .success(let weatherResponse):
                       success(weatherResponse)
                      case .failure(_):
                          failure()
                      }
              }
          }
}
