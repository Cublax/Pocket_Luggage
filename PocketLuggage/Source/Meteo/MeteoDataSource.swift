//
//  MeteoDataSource.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

struct VisibleWeather: Equatable {
    let city: String
    let iconCode: String
    let currentTemperature: String
    let currentWeather: String
    let temperatureMax: String
    let temperatureMin: String
    let sunrise: String
    let sunset: String
}

struct VisibleForecast: Equatable {
    let time: String
    let image: String
    let temperature: String
}

class MeteoDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    typealias Item = MeteoViewModel.Item
    
    // MARK: - Private
    
    private var items: [Item] = []
    
    // MARK: - Public
    
    func update(with items: [Item]) {
       self.items = items
    }
    
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
        case .forecast(forecast: let visibleForecast):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
            cell.configure(with: visibleForecast)
            return cell
        }
    }
}
