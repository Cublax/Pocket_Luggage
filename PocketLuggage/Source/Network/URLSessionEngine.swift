//
//  URLSessionEngine.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 24/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

enum URLSessionEngineError: Error {
    case invalidURLResponseType
}

final class URLSessionEngine: HTTPEngine {

    // MARK: - Properties

    private let session: URLSession

    // MARK: - Init

    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }

    // MARK: - Internal

    func send(request: URLRequest, cancelledBy token: RequestCancellationToken, completion: @escaping HTTPCompletionHandler) {
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if urlResponse != nil {
                guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
                    completion(data, nil, URLSessionEngineError.invalidURLResponseType)
                    return
                }
                completion(data, httpUrlResponse, error)
            } else {
                completion(data, nil, error)
            }
        }

        task.resume()
        token.willDeallocate = { task.cancel() }
    }

    // MARK: - Deinit

    deinit {
        session.invalidateAndCancel()
    }
}
