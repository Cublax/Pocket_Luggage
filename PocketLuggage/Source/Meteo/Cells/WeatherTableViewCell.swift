//
//  WeatherTableViewCell.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 04/09/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currentCityLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImageLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeatherTitleLabel: UILabel!
    
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var forecastLabel: UILabel!
    

    func configure(with visibleWeather: VisibleWeather) {
        self.currentCityLabel.text = visibleWeather.city
        self.currentWeatherImageLabel.text = visibleWeather.iconCode.asWeatherIcon ?? ""
        self.currentTemperatureLabel.text = visibleWeather.currentTemperature
        self.currentWeatherTitleLabel.text = visibleWeather.currentWeather
        self.tempMinLabel.text = visibleWeather.temperatureMin
        self.tempMaxLabel.text = visibleWeather.temperatureMax
        self.sunriseLabel.text = visibleWeather.sunrise
        self.sunsetLabel.text = visibleWeather.sunset
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        currentCityLabel.text = nil
        currentWeatherImageLabel.text = nil
        currentTemperatureLabel.text = nil
        currentWeatherTitleLabel.text = nil
        tempMinLabel.text = nil
        tempMaxLabel.text = nil
        sunriseLabel.text = nil
        sunsetLabel.text = nil
        forecastLabel.text = nil
    }
}
