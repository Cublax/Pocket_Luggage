//
//  Icon+String.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 23/09/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

extension String {
    var asWeatherIcon: String? {
        switch self {
        case "01d":
            return "\u{f11b}"
        case "01n":
            return "\u{f110}"
        case "02d":
            return "\u{f112}"
        case "02n":
            return "\u{f104}"
        case "03d", "03n":
            return "\u{f111}"
        case "04d", "04n":
            return "\u{f111}"
        case "09d", "09n":
            return "\u{f116}"
        case "10d", "10n":
            return "\u{f113}"
        case "11d", "11n":
            return "\u{f10d}"
        case "13d", "13n":
            return "\u{f119}"
        case "50d", "50n":
            return "\u{f10e}"
        default:
            return nil
        }
    }
}


extension String {
    var weekDayFormat: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let convertedDate = dateFormatter.date(from: self) else { return nil }
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: convertedDate)
    }
    
    var unix: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let convertedDate = dateFormatter.date(from: self) else { return nil }
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: convertedDate)
    }
}

extension Double {
    var hourMinutesFormat: String? {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
}






