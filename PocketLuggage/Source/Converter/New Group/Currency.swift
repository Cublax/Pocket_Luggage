//
//  Currency.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 01/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let date: String
    let rates: [String: Double]
}

struct Symbols: Codable {
    let symbols: [String: String]
}
