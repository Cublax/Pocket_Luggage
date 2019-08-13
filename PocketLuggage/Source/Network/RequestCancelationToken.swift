//
//  RequestCancelationToken.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 01/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class RequestCancellationToken {
    
    init () {}
    
    deinit {
        willDealocate?()
    }
    
    var willDealocate:(() -> Void)?
}
