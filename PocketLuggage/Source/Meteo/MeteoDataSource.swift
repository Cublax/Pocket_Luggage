//
//  MeteoDataSource.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

struct VisibleWeather {
    let city: String
    let currentWeatherImage: String
    let currentTemperature: String
    let currentWeather: String
    let temperatureMax: String
    let temperatureMin: String
    let sunrise: String
    let sunset: String
    let firstForecastTime: String
    let firstForecastImage: String
    let firstForecastTemperature: String
    let secondForecastTime: String
    let secondForecastImageView: String
    let secondForecastTemperature: String
    let thirdForecastTime: String
    let thirdForecastImage: String
    let thirdForecastTemperature: String
    let fourthForecastTime: String
    let fourthForecastImage: String
    let fourthForecastTemperature: String
}

class MeteoDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    typealias Item = MeteoViewModel.Item
    
    var items: [Item] = []
    
    // MARK: - Public
    
    func update(with items: [Item]) {
       self.items = items
    }
    
    // MARK: - UITableViewDelegate
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard indexPath.item < items.count else { fatalError() }
        switch items[indexPath.item] {
        case .weather(weather: let visibleWeather):
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
            cell.configure(with: visibleWeather)
            return cell
        }
    }
}
