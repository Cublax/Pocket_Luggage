//
//  Context.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 24/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class Context {

    // MARK: - Public properties

    let networkClient: HTTPClient

    // MARK: - Initializer

    init(networkClient: HTTPClient) {
        self.networkClient = networkClient
    }
}
