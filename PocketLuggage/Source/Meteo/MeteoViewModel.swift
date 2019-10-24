//
//  MeteoViewModel.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol MeteoViewModelDelegate: class {
    func shouldDisplayAlert(for type: AlertType)
}

final class MeteoViewModel {
    
    // MARK: - Properties
    
    private let repository: MeteoRepositoryType
    
    private weak var delegate: MeteoViewModelDelegate?
    
    var weatherItems: [WeatherItem] = [] {
        didSet {
            let items = weatherItems.map { Item(weatherItem: $0) }
            self.items?(items)
        }
    }
    
    // MARK: - Initializer
    
    init(repository: MeteoRepositoryType, delegate: MeteoViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Outputs
    
    var items: (([Item]) -> Void)?
    
    enum Item: Equatable {
        case weather(weather: VisibleWeather)
        case forecast(forecast: VisibleForecast)
    }
    
    enum WeatherItem {
        case weather(city: City, currentForecast: Forecast)
        case forecast(forecast: Forecast)
    }
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        repository.getForecastMeteoBerlin(success: { (weather1) in
            self.repository.getForecastMeteoAnnecy(success: { (weather2) in
                DispatchQueue.main.async {
                    self.weatherItems = MeteoViewModel.initialize(with: weather1, weather2: weather2)
                }
            }, failure: { [weak self] in
                    self?.delegate?.shouldDisplayAlert(for: .requestError)
                })
            }, failure: { [weak self] in
                  self?.delegate?.shouldDisplayAlert(for: .requestError)
            })
    }
    
    private static func initialize(with weather1: Weather, weather2: Weather) -> [WeatherItem] {
        var weatherItems: [WeatherItem] = []
        guard let current1 = weather1.forecasts.first else { return [] }
        weatherItems.append(.weather(city: weather1.city, currentForecast: current1))
        
        let forecasts: [WeatherItem] = weather1.forecasts
            .filter { $0.dtTxt.contains("12:00:00") }
            .map { .forecast(forecast: $0) }
        
        weatherItems.append(contentsOf: forecasts)
        
        guard let current2 = weather2.forecasts.first else { return [] }
        
        weatherItems.append(.weather(city: weather2.city, currentForecast: current2))
        
        let forecasts2: [WeatherItem] = weather2.forecasts
            .filter { $0.dtTxt.contains("12:00:00") }
            .map { .forecast(forecast: $0) }
        weatherItems.append(contentsOf: forecasts2)
        
        return weatherItems
    }
}

extension MeteoViewModel.Item {
    init(weatherItem: MeteoViewModel.WeatherItem) {
        switch weatherItem {
        case .weather(city: let current):
            self = .weather(weather: VisibleWeather(city: "\(current.city.name), \(current.city.country)",
                iconCode: current.currentForecast.weather.first?.icon ?? "",
                currentTemperature: "\(current.currentForecast.main.temp)°C",
                currentWeather: current.currentForecast.weather.first?.weatherDescription ?? "",
                temperatureMax: "Max: \(current.currentForecast.main.tempMax)°C",
                temperatureMin: "Min: \(current.currentForecast.main.tempMin)°C",
                sunrise: Double(current.city.sunrise).hourMinutesFormat,
                sunset: Double(current.city.sunset).hourMinutesFormat ))
        case .forecast(forecast: let forecast):
            self = .forecast(forecast: VisibleForecast(time: forecast.dtTxt.weekDayFormat,
                                                       image: forecast.weather.first?.icon ?? "",
                                                       temperature: "\(forecast.main.temp)°C"))
        }
    }
}







