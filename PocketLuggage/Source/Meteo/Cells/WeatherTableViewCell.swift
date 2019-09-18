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
    
    // First StackView
    
    @IBOutlet weak var currentWeatherImageLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeatherTitleLabel: UILabel!
    
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    /// Forecasts
    
    @IBOutlet weak var forecastLabel: UILabel!
    
    // Time Labels
    @IBOutlet weak var firstForecastTimeLabel: UILabel!
    @IBOutlet weak var secondForecastTimeLabel: UILabel!
    @IBOutlet weak var thirdForecastTimeLabel: UILabel!
    @IBOutlet weak var fourthForecastTimeLabel: UILabel!
    
    //Temperature
    
    @IBOutlet weak var firstForecastTemperatureLabel: UILabel!
    @IBOutlet weak var secondForecastTemperatureLabel: UILabel!
    @IBOutlet weak var thirdForecastTemperatureLabel: UILabel!
    @IBOutlet weak var fourthForecastTemperatureLabel: UILabel!
    
    // Image

    @IBOutlet weak var firstForecastImageLabel: UILabel!
    @IBOutlet weak var secondForecastImageLabel: UILabel!
    @IBOutlet weak var thirdForecastImageLabel: UILabel!
    @IBOutlet weak var fourthForecastImageLabel: UILabel!
    
    
    
    func configure(with visibleWeather: VisibleWeather) {
        self.currentCityLabel.text = visibleWeather.city
        self.currentWeatherImageLabel.text = visibleWeather.currentWeatherImage
        self.currentTemperatureLabel.text = visibleWeather.currentTemperature
        self.currentWeatherTitleLabel.text = visibleWeather.currentWeather
        self.tempMinLabel.text = visibleWeather.temperatureMin
        self.tempMaxLabel.text = visibleWeather.temperatureMax
        self.sunriseLabel.text = visibleWeather.sunrise
        self.sunsetLabel.text = visibleWeather.sunset
        self.firstForecastTimeLabel.text = visibleWeather.firstForecastTime
        self.firstForecastImageLabel.text = visibleWeather.firstForecastImage
        self.firstForecastTemperatureLabel.text = visibleWeather.firstForecastTemperature
        self.secondForecastTimeLabel.text = visibleWeather.secondForecastTime
        self.secondForecastImageLabel.text = visibleWeather.secondForecastImageView
        self.secondForecastTemperatureLabel.text = visibleWeather.secondForecastTemperature
        self.thirdForecastTimeLabel.text = visibleWeather.thirdForecastTime
        self.thirdForecastImageLabel.text = visibleWeather.thirdForecastImage
        self.thirdForecastTemperatureLabel.text = visibleWeather.thirdForecastTemperature
        self.fourthForecastTimeLabel.text = visibleWeather.fourthForecastTime
        self.fourthForecastImageLabel.text = visibleWeather.fourthForecastImage
        self.fourthForecastTemperatureLabel.text = visibleWeather.fourthForecastTemperature
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        forecastLabel.text = nil
        // etc...
    }
}
