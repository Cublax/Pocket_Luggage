//
//  TranslatorViewModelTests.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 25/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import PocketLuggage


fileprivate final class MockTranslateRepository: TranslatorRepositoryType {
    
    var isSuccess = true
    var returnedText = ""
    var error: Error? = nil
    
    func translateRequest(for text: String, from originLanguage: String, to destinationLanguage: String, callback: @escaping ((String?, Error?) -> Void)) {
        isSuccess ? callback(returnedText, error) : callback(nil, nil)
    }
}

final class TranslatorViewModelTests: XCTestCase {
    
    fileprivate let mockTranslatorRepository = MockTranslateRepository()
    
    func testtoto() {
        let viewModel = TranslatorViewModel(repository: mockTranslatorRepository,
                                            delegate: nil)
        mockTranslatorRepository.isSuccess = true
        mockTranslatorRepository.returnedText = "Hello"
        mockTranslatorRepository.error = nil
        let expectation = self.expectation(description: "Returned text")
        
        viewModel.traductedText = { text in
            XCTAssertEqual(text, "Hello")
            expectation.fulfill()
        }
        
        viewModel.didPressTranslate(for: "Bonjour", from: "fr", to: "en")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
