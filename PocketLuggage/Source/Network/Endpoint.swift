//
//  Endpoint.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 24/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: HTTPRequestParameters? { get }
    var timeout: TimeInterval { get }
}

extension Endpoint {
    public var timeout: TimeInterval {
        return 30
    }
}
