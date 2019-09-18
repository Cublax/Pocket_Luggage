//
//  WeatherItem.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

// MARK: - Weather
struct WeatherItem {
    let weathers: [WeatherElementItem]
    let main: MainItem
    let sys: SysItem
    let name: String
}


// MARK: - Main
struct MainItem {
    let temp: Double
    let tempMin, tempMax: Double
}

extension MainItem {
    init(main: Main) {
        self.temp = main.temp
        self.tempMin = main.tempMin
        self.tempMax = main.tempMax
    }
}

// MARK: - Sys
struct SysItem {
    let sunrise, sunset: Int
}

extension SysItem {
    init(sys: Sys) {
        self.sunrise = sys.sunrise
        self.sunset = sys.sunset
    }
}


// MARK: - WeatherElement
struct WeatherElementItem {
    let weatherDescription, icon: String
}

extension WeatherElementItem {
    init(weatherElement: WeatherElement) {
        self.weatherDescription = weatherElement.weatherDescription
        self.icon = weatherElement.icon
    }
}
