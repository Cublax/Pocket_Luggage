//
//  MeteoViewModel.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol MeteoViewModelDelegate: class {
    
}

final class MeteoViewModel {
    
    // MARK: - Properties
    
    private let repository: MeteoRepository
    
    private weak var delegate: MeteoViewModelDelegate?

    var _items: [WeatherItem] = [] {
        didSet {
            let items = _items.map { Item(item: $0) }
            weatherItems?(items)
        }
    }
    
    // MARK: - Initializer
    
    init(repository: MeteoRepository, delegate: MeteoViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Outputs
    
    var weatherItems: (([Item]) -> Void)?

    enum Item {
        case weather(weather: VisibleWeather)
    }

    
    // MARK: - Inputs
    
    func viewDidLoad() {
        repository.getMeteo { [weak self] weatherItem in
            self?._items = [weatherItem]
        }
    }
    
    func initialize(from: WeatherItem) {
        
    }
    
}

//extension VisibleWeather {
//    init(item: WeatherItem) {
//        self.city =
//        self.currentTemperature = ""
//        self.currentWeather = ""
//        self.currentWeatherImage = ""
//        self.firstForecastImage = ""
//        self.firstForecastTime = ""
//        self.firstForecastTemperature = ""
//        self.secondForecastTemperature = ""
//        self.secondForecastTime = ""
//        self.secondForecastImageView = ""
//        self.thirdForecastTemperature = ""
//        self.thirdForecastImage = ""
//        self.thirdForecastTime = ""
//        self.fourthForecastTemperature = ""
//        self.fourthForecastImage = ""
//        self.fourthForecastTime = ""
//    }
//}

extension MeteoViewModel.Item {
    init(item: WeatherItem) {
        self = .weather(weather: VisibleWeather(city: item.name,
                                                currentWeatherImage: "",
                                                currentTemperature: "\(item.main.temp)°C",
                                                currentWeather: "",
                                                temperatureMax: "Max: \(item.main.tempMax)°C",
            temperatureMin: "Min: \(item.main.tempMin)°C",
                                                sunrise: "",
                                                sunset: "",
                                                firstForecastTime: "",
                                                firstForecastImage: "",
                                                firstForecastTemperature: "",
                                                secondForecastTime: "",
                                                secondForecastImageView: "",
                                                secondForecastTemperature: "",
                                                thirdForecastTime: "",
                                                thirdForecastImage: "",
                                                thirdForecastTemperature: "",
                                                fourthForecastTime: "",
                                                fourthForecastImage: "",
                                                fourthForecastTemperature: ""))

    }
}
