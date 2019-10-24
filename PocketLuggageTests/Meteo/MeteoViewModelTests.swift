//
//  MeteoViewModelTests.swift
//  PocketLuggageTests
//
//  Created by Alexandre Quiblier on 30/09/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import PocketLuggage

fileprivate final class MockMeteoRepository: MeteoRepositoryType {
    func getForecastMeteoBerlin(success: @escaping (Weather) -> Void, failure: @escaping (() -> Void)) {
        success(Weather(forecasts: [Forecast(dt: 1, main: ForecastMainClass(temp: 1, tempMin: 1, tempMax: 1), weather: [ForecastWeather(weatherDescription: "1", icon: "1")], dtTxt: "2019-10-04 12:00:00")], city: City(name: "Berlin", country: "DE", population: 1, timezone: 1, sunrise: 1570165907, sunset: 1570165907)))
    }
    
    func getForecastMeteoAnnecy(success: @escaping (Weather) -> Void, failure: @escaping (() -> Void)) {
        success(Weather(forecasts: [Forecast(dt: 2, main: ForecastMainClass(temp: 2, tempMin: 2, tempMax: 2), weather: [ForecastWeather(weatherDescription: "2", icon: "2")], dtTxt: "2019-10-04 12:00:00")], city: City(name: "Annecy", country: "FR", population: 2, timezone: 2, sunrise: 1570165907, sunset: 1570165907)))
    }
    
}

fileprivate final class MockMeteoRepository2: MeteoRepositoryType {
    func getForecastMeteoBerlin(success: @escaping (Weather) -> Void, failure: @escaping (() -> Void)) {
        success(Weather(forecasts: [Forecast(dt: 1, main: ForecastMainClass(temp: 1, tempMin: 1, tempMax: 1), weather: [ForecastWeather(weatherDescription: "1", icon: "1")], dtTxt: "2019-10-04 12:00:00")], city: City(name: "Berlin", country: "DE", population: 1, timezone: 1, sunrise: 1570165907, sunset: 1570165907)))
    }
    
    func getForecastMeteoAnnecy(success: @escaping (Weather) -> Void, failure: @escaping (() -> Void)) {
        success(Weather(forecasts: [Forecast(dt: 2,
                             main: ForecastMainClass(temp: 2, tempMin: 2, tempMax: 2),
                             weather: [],
                             dtTxt: "2019-10-04 12:00:00")],
        city: City(name: "Annecy",
        country: "FR",
        population: 2,
        timezone: 2,
        sunrise: 1570165907,
        sunset: 1570165907)))
    }
}

fileprivate final class MockMeteoViewModelDelegate: MeteoViewModelDelegate {
    var alert: AlertType? = nil
    
    var languagetype: LanguageViewType = .origin
    
    func didPresentLanguages(for type: LanguageViewType) {
        self.languagetype = type
    }
    
    func shouldDisplayAlert(for type: AlertType) {
        self.alert = type
    }
}
 

final class MeteoViewModelTests: XCTestCase {
    
    
    func testGivenAViewModelWhenViewDidLoadThenWeatherItemIsCorrectlyCreated() {
        let mockRepository = MockMeteoRepository()
        let delegate = MockMeteoViewModelDelegate()
        let viewModel = MeteoViewModel(repository: mockRepository, delegate: delegate)
        let expectation = self.expectation(description: "Meteo request on berlin is correctly returned")
        
        let exepectedResult: [MeteoViewModel.Item] = [.weather(weather: VisibleWeather(city: "Berlin, DE",
                                                                                       iconCode: "1",
                                                                                       currentTemperature: "1.0°C",
                                                                                       currentWeather: "1",
                                                                                       temperatureMax: "Max: 1.0°C",
                                                                                       temperatureMin: "Min: 1.0°C",
                                                                                       sunrise: "07:11 AM",
                                                                                       sunset: "07:11 AM")),
                                                      .forecast(forecast: VisibleForecast(time: "Friday",
                                                                                          image: "1",
                                                                                          temperature: "1.0°C")),
                                                      .weather(weather: VisibleWeather(city: "Annecy, FR",
                                                                                       iconCode: "2",
                                                                                       currentTemperature: "2.0°C",
                                                                                       currentWeather: "2",
                                                                                       temperatureMax: "Max: 2.0°C",
                                                                                       temperatureMin: "Min: 2.0°C",
                                                                                       sunrise: "07:11 AM",
                                                                                       sunset: "07:11 AM")),
                                                      .forecast(forecast: VisibleForecast(time: "Friday",
                                                                                          image: "2",
                                                                                          temperature: "2.0°C"))]
        
        viewModel.items = { items in
            XCTAssertEqual(items, exepectedResult)
            expectation.fulfill()
        }

        viewModel.viewDidLoad()
                
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAViewModelWhenViewDidLoadThenWeatherItemIsCorrectlyCreatedButSomeStuffGetDefaultValue() {
        let mockRepository = MockMeteoRepository2()
        let delegate = MockMeteoViewModelDelegate()
        let viewModel = MeteoViewModel(repository: mockRepository, delegate: delegate)

        let expectation = self.expectation(description: "Meteo request on berlin is correctly returned but some stuff get default value")


         let expectedResult: [MeteoViewModel.Item] = [.weather(weather: VisibleWeather(city: "Berlin, DE",
                                                                                       iconCode: "1",
                                                                                       currentTemperature: "1.0°C",
                                                                                       currentWeather: "1",
                                                                                       temperatureMax: "Max: 1.0°C",
                                                                                       temperatureMin: "Min: 1.0°C",
                                                                                       sunrise: "07:11 AM",
                                                                                       sunset: "07:11 AM")),
                                                      .forecast(forecast: VisibleForecast(time: "Friday",
                                                                                          image: "1",
                                                                                          temperature: "1.0°C")),
                                                      .weather(weather: VisibleWeather(city: "Annecy, FR",
                                                                                       iconCode: "",
                                                                                       currentTemperature: "2.0°C",
                                                                                       currentWeather: "",
                                                                                       temperatureMax: "Max: 2.0°C",
                                                                                       temperatureMin: "Min: 2.0°C",
                                                                                       sunrise: "07:11 AM",
                                                                                       sunset: "07:11 AM")),
                                                      .forecast(forecast: VisibleForecast(time: "Friday",
                                                                                          image: "",
                                                                                          temperature: "2.0°C"))]
        
            viewModel.items = { items in
                XCTAssertEqual(items, expectedResult)
                expectation.fulfill()
            }
        
        viewModel.viewDidLoad()
        
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}


