//
//  FIXERRequestBuilder.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 24/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class PocketLuggageRequestBuilder {

    // MARK: - Private properties

    private let url: URL

    // MARK: - Initializer

    init(url: URL = URL(string: "http://data.fixer.io/api/")!) {
        self.url = url
    }

    // MARK: - Build request

    func buildRequest(for endpoint: Endpoint) -> HTTPRequest? {
        return try? HTTPRequest(baseURL: url,
                                path: endpoint.path,
                                method: endpoint.method,
                                parameters: endpoint.parameters,
                                timeout: endpoint.timeout)
    }
}
