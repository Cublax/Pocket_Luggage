//
//  MeteoRepository.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol MeteoRepositoryType: class {
    func getForecastMeteoBerlin(completion: @escaping (Weather) -> Void)
    func getForecastMeteoAnnecy(completion: @escaping (Weather) -> Void)
}

final class MeteoRepository: MeteoRepositoryType {
    
    // MARK: - Properties
    
    private let client: HTTPClient
    
    private let token = RequestCancellationToken()
    
    // MARK: - Initializer

    init() {
        self.client = HTTPClient(cancellationToken: token)
    }
    
    // MARK: - Requests
    
    func getForecastMeteoBerlin(completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Berlin,de&units=metric&APPID=8ef2b02e2cabd2d7092208a0fb5a7688") else {return}
        
        client.request(type: Weather.self, requestType: .GET, url: url) { (response) in
            completion(response)
        }
    }
    
    func getForecastMeteoAnnecy(completion: @escaping (Weather) -> Void) {
           guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Annecy,fr&units=metric&APPID=8ef2b02e2cabd2d7092208a0fb5a7688") else {return}
           
           client.request(type: Weather.self, requestType: .GET, url: url) { (response) in
               completion(response)
           }
       }
}
