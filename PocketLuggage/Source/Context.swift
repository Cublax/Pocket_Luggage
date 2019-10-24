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

    let requestBuilder: PocketLuggageRequestBuilder

    // MARK: - Initializer

    init(networkClient: HTTPClient, requestBuilder: PocketLuggageRequestBuilder) {
        self.networkClient = networkClient
        self.requestBuilder = requestBuilder
    }
}
