//
//  Alert.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 11/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

enum AlertType: Equatable {
    case translationError
}

struct Alert: Equatable {
    let title: String
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .translationError:
            self = Alert(title: "Alert", message: "An error has occured")
        }
    }
}
