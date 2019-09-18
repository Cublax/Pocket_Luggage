//
//  HTTPClient.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 01/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation


class HTTPClient {
    
    enum RequestType: String {
        case POST = "POST"
        case GET = "GET"
    }
    
    private let engine: HTTPEngineType
    
    private let cancellationToken: RequestCancellationToken
    
    private let jsonDecoder: JSONDecoder
    
    init(cancellationToken: RequestCancellationToken) {
        self.engine = HTTPEngine()
        self.cancellationToken = cancellationToken
        self.jsonDecoder = JSONDecoder()
    }
    
    func request<T>(type: T.Type, requestType: RequestType, url: URL, completion: @escaping (T) -> Void) where T: Codable {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        engine.send(request: request,
                    cancelledBy: self.cancellationToken) { (data, httpUrlResponse, error) in
                        guard let data = data else { return }
                        self.decodeJSON(type: T.self, data: data, completion: completion)
    }
}
    
    private func decodeJSON<T>(type: T.Type, data: Data, completion: @escaping (T) -> Void) where T: Decodable {
        guard let decodedData = try? jsonDecoder.decode(type.self, from: data) else { print("Decoder was unable to decode: \(type.self)"); return }
        completion(decodedData)
    }
}
