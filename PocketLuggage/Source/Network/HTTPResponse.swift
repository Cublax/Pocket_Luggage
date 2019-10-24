//
//  HTTPResponse.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 23/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

final class HTTPResponse<T> {
    
    let result: Result<T>
    
    let originalData: Data?
    
    let statusCode: Int?
    
    init(result: Result<T>, originalData: Data?, statusCode: Int?) {
        self.result = result
        self.originalData = originalData
        self.statusCode = statusCode
    }
}
