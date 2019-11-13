//
//  PocketLuggageRequestBuilderTest.swift
//  PocketLuggageTests
//
//  Created by Alexandre Quiblier on 24/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import PocketLuggage

final class PocketLuggageRequestBuilderTest: XCTestCase {

    func testThatBuildRequestCorrectly() {
        let url = URL(string: "http://data.fixer.io/api/")!
        let builder = ConverterRequestBuilder(url: url)

        let result = builder.buildRequest(for: MockEndPoint())

        XCTAssertEqual(result?.urlComponents.path, "search")
        XCTAssertEqual(result?.method, .GET)
        XCTAssertNil(result?.parameters)
    }
}

class MockEndPoint: Endpoint {
    let path: String
    let method: HTTPMethod
    let parameters: HTTPRequestParameters?
    
    init() {
        self.path = "search"
        self.method = .GET
        self.parameters = nil
    }
}
