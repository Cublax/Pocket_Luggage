//
//  Forecast.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 18/09/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

// MARK: - Forecast
struct Weather: Codable {
    let forecasts: [Forecast]
    let city: City

    enum CodingKeys: String, CodingKey {
        case forecasts = "list"
        case city
    }
}

// MARK: - ForecastCity
struct City: Codable {
    let name: String
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - ForecastList
struct Forecast: Codable {
    let dt: Int
    let main: ForecastMainClass
    let weather: [ForecastWeather]
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather
        case dtTxt = "dt_txt"
    }
}

// MARK: - ForecastMainClass
struct ForecastMainClass: Codable {
    let temp, tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}


// MARK: - ForecastWeather
struct ForecastWeather: Codable {
    let weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
}

