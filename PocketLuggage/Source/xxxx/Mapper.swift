//
//  Mapper.swift
//  iOS-Basic-Networking-Module
//
//  Created by Sebastien Bastide on 21/08/2019.
//  Copyright © 2019 Sebastien Bastide. All rights reserved.
//

import Foundation

protocol Map {
    associatedtype Object: Decodable
}

final class Mapper<Object: Decodable>: Map {

    // MARK: - Properties

    private let successStatusCode = 200

    // MARK: - Class's Methods

    func encode(_ baseUrl: URL, _ parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else { return baseUrl }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let urlParameted = urlComponents.url else { return baseUrl }
        return urlParameted
    }

    func decode(_ data: Data, _ response: HTTPURLResponse) -> Result<Object, Error> {
        guard response.statusCode == successStatusCode, let object = try? JSONDecoder().decode(Object.self, from: data) else {
            return .failure(NetworkError.invalidMappingData)
        }
        return .success(object)
    }
}
