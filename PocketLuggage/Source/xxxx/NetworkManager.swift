//
//  NetworkManager.swift
//  iOS-Basic-Networking-Module
//
//  Created by Sebastien Bastide on 21/08/2019.
//  Copyright © 2019 Sebastien Bastide. All rights reserved.
//

import Foundation

public protocol Network {
    associatedtype Object: Decodable
    func request(callback: @escaping (Result<Object, Error>) -> Void)
}

final public class NetworkManager<Object: Decodable>: Network {

    // MARK: - Properties

    private let baseUrl: URL
    private let parameters: [(String, Any)]?
    private let client: HTTPClient
    private var url: URL { return mapper.encode(baseUrl, parameters) }
    private lazy var mapper: Mapper = Mapper<Object>()

    // MARK: - Initializer

    public init(baseUrl: URL, parameters: [(String, Any)]? = nil, client: HTTPClient = Client()) {
        self.baseUrl = baseUrl
        self.parameters = parameters
        self.client = client
    }

    // MARK: - Class's Methods

    public func request(callback: @escaping (Result<Object, Error>) -> Void) {
        Logger(url: url).show()
        client.request(url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data, let response):
                callback(self.mapper.decode(data, response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
