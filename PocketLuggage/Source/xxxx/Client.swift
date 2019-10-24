//
//  Client.swift
//  iOS-Basic-Networking-Module
//
//  Created by Sebastien Bastide on 21/08/2019.
//  Copyright © 2019 Sebastien Bastide. All rights reserved.
//

import Foundation

public typealias HTTPResult = (Result<(Data, HTTPURLResponse), Error>) -> Void

public protocol HTTPClient: class {
    func request(_ url: URL, callback: @escaping HTTPResult)
}

public class Client: HTTPClient {

    // MARK: - Properties

    private var session: URLSession
    private var task: URLSessionDataTask?

    // MARK: - Initialization

    public init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - Class's Methods

    public func request(_ url: URL, callback: @escaping HTTPResult) {
        task?.cancel()
        task = session.dataTask(with: url) { data, response, _ in
            DispatchQueue.main.async {
                guard let data = data, let response = response as? HTTPURLResponse else {
                    callback(.failure(NetworkError.invalidUrl))
                    return
                }
                callback(.success((data, response)))
            }
        }
        task?.resume()
    }
}
