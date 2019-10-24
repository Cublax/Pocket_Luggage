//
//  RequestCancelationTokenTest.swift
//  
//
//  Created by Alexandre Quiblier on 23/10/2019.
//


import XCTest
@testable import PocketLuggage

final class RequestCancellationTokenTests: XCTestCase {

    func testItExecutesBlockWhenDeallocating() {
        let expectation = self.expectation(description: "`willDeallocate` block was executed")

        autoreleasepool {
            let token = RequestCancellationToken()
            token.willDeallocate = { expectation.fulfill() }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
