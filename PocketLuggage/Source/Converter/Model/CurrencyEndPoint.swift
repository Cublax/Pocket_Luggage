//
//  CurrencyEndPoint.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 24/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

struct CurrencyEndpoint: Endpoint {
    let path: String
    let method: HTTPMethod
    let parameters: HTTPRequestParameters?
    
    init() {
        self.path = "latest?access_key=bc44d0b411a56c92c53f0b0962be3a0f&base=EUR"
        self.method = .GET
        self.parameters = nil
    }
}
