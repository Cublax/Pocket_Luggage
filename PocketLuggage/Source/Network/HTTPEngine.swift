//
//  HTTPEngine.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 01/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

public typealias HTTPCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

public protocol HTTPEngine {
    func send(request: URLRequest, cancelledBy token: RequestCancellationToken, completion: @escaping HTTPCompletionHandler)
}
