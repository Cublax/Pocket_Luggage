//
//  ForecastTableViewCell.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 19/09/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var forecastTimeLabel: UILabel!
    @IBOutlet weak var forecastImageLabel: UILabel!
    @IBOutlet weak var forecastTemperatureLabel: UILabel!
    
    func configure(with visibleForecast: VisibleForecast) {
        forecastTimeLabel.text = visibleForecast.time
        forecastImageLabel.text = visibleForecast.image.asWeatherIcon ?? ""
        forecastTemperatureLabel.text = visibleForecast.temperature
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        forecastTimeLabel.text = nil
        forecastImageLabel.text = nil
        forecastTemperatureLabel.text = nil
    }
}
