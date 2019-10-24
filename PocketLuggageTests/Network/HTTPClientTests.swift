//
//  HTTPClientTests.swift
//  PocketLuggageTests
//
//  Created by Alexandre Quiblier on 23/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//
import XCTest
@testable import PocketLuggage

class HTTPClientTests: XCTestCase {

    private let cancellationToken = RequestCancellationToken()

    private let client = HTTPClient(engine: .urlSession(.default))

    private let requestBuilder = URLRequestBuilder()

    func testWhenSendingGetRequest_itReceivesValidResponse() {
        let expectation = self.expectation(description: "received data response")
        let httpRequest = try! HTTPRequest(baseURL: URL(string:"https://httpbin.org")!,
                                           path: "get",
                                           method: .GET,
                                           parameters: nil,
                                           timeout: 4)
        let request = try! requestBuilder.buildURLRequest(from: httpRequest)

        retry(block: { (retry, fulfill) in
            self.client
                .executeTask(request, cancelledBy: self.cancellationToken)
                .processDataResponse(callback: { response in
                    switch response.result {
                    case .success:
                        fulfill()
                    case .failure:
                        retry()
                    }
                })
        }, untilItFulfillsExpectation: expectation, orNumberOfTimes: 3)

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testWhenSendingJSONContentInPostRequest_itReceivesValidJSONResponse() {
        let expectation = self.expectation(description: "received codable response")
        let httpRequest = try! HTTPRequest(baseURL: URL(string: "https://httpbin.org/post")!,
                                           path: "post",
                                           method: .POST,
                                           parameters: HTTPRequestParameters(value: ["key": "value"]))
        let request = try! requestBuilder.buildURLRequest(from: httpRequest)

        struct ResponseObject: Codable {
            let json: NestedResponseObject
        }

        struct NestedResponseObject: Codable {
            let key: String
        }
        
        retry(block: { (retry, fulfill) in
            self.client
                .executeTask(request, cancelledBy: self.cancellationToken)
                .processCodableResponse(callback: { (response: HTTPResponse<ResponseObject>) in
                    switch response.result {
                    case .success(let object):
                        XCTAssertEqual(object.json.key, "value")
                        fulfill()
                    case .failure:
                        retry()
                    }
                })
        }, untilItFulfillsExpectation: expectation, orNumberOfTimes: 3)

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testWhenSendingGetHTTPRequest_itReceivesValidResponse() {
        let expectation = self.expectation(description: "received data response")
        let httpRequest = try! HTTPRequest(baseURL: URL(string:"https://httpbin.org")!,
                                           path: "get",
                                           method: .GET,
                                           parameters: nil,
                                           timeout: 4)

        retry(block: { (retry, fulfill) in
            self.client
                .executeTask(httpRequest, cancelledBy: self.cancellationToken)
                .processDataResponse(callback: { response in
                    switch response.result {
                    case .success:
                        fulfill()
                    case .failure:
                        retry()
                    }
                })
        }, untilItFulfillsExpectation: expectation, orNumberOfTimes: 3)

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testWhenSendingJSONContentInPostHTTPRequest_itReceivesValidJSONResponse() {
        let expectation = self.expectation(description: "received codable response")
        let httpRequest = try! HTTPRequest(baseURL: URL(string: "https://httpbin.org/post")!,
                                           path: "post",
                                           method: .POST,
                                           parameters: HTTPRequestParameters(value: ["key": "value"]))
        
        struct ResponseObject: Codable {
            let json: NestedResponseObject
        }
        
        struct NestedResponseObject: Codable {
            let key: String
        }
        
        retry(block: { (retry, fulfill) in
            self.client
                .executeTask(httpRequest, cancelledBy: self.cancellationToken)
                .processCodableResponse(callback: { (response: HTTPResponse<ResponseObject>) in
                    switch response.result {
                    case .success(let object):
                        XCTAssertEqual(object.json.key, "value")
                        fulfill()
                    case .failure:
                        retry()
                    }
                })
        }, untilItFulfillsExpectation: expectation, orNumberOfTimes: 3)
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    

    func testWhenSendingHTTPRequestWithABigDelay_ItCancelsRequest() {
        let httpRequest = try! HTTPRequest(baseURL: URL(string:"https://httpbin.org")!,
                                           path: "delay/10",
                                           method: .GET,
                                           parameters: nil,
                                           timeout: 4)

        retry(block: { (retry, fulfill) in
            var cancellationToken: RequestCancellationToken? = RequestCancellationToken()
            self.client
                .executeTask(httpRequest, cancelledBy: cancellationToken!)
                .processDataResponse { (response) in
                    switch response.result {
                    case .success:
                        XCTFail()
                    case .failure:
                        fulfill()
                    }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // cancel after 2 seconds
                cancellationToken = nil
            }
        }, untilItFulfillsExpectation: self.expectation(description: "did cancel request"), orNumberOfTimes: 3)
        
        waitForExpectations(timeout: 16, handler: nil)
    }

    func testWhenSendingRequestWithABigDelay_ItCancelsRequest() {
        let httpRequest = try! HTTPRequest(baseURL: URL(string:"https://httpbin.org")!,
                                           path: "delay/10",
                                           method: .GET,
                                           parameters: nil,
                                           timeout: 4)

        let request = try! requestBuilder.buildURLRequest(from: httpRequest)

        retry(block: { (retry, fulfill) in
            var cancellationToken: RequestCancellationToken? = RequestCancellationToken()
            self.client
                .executeTask(request, cancelledBy: cancellationToken!)
                .processDataResponse { (response) in
                    switch response.result {
                    case .success:
                        XCTFail()
                    case .failure:
                        fulfill()
                    }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // cancel after 2 seconds
                cancellationToken = nil
            }
        }, untilItFulfillsExpectation: self.expectation(description: "did cancel request"), orNumberOfTimes: 3)
        
        waitForExpectations(timeout: 16, handler: nil)
    }
}
