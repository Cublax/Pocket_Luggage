//
//  LanguageViewModelTests.swift
//  PocketLuggageTests
//
//  Created by Alexandre Quiblier on 16/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import PocketLuggage

final class LanguageViewModelTests: XCTestCase {
    
    func testGivenBlablaaWhenThenBlabla() {
        let mockRepository = MockLanguageRepository()
        let delegate = MockLanguageViewControllerDelegate()
        let viewModel = LanguageViewModel(languageType: .origin,
                                          repository: mockRepository,
                                          delegate: delegate)
        let expectation = self.expectation(description: "Returned Text")
        
        viewModel.titleText = { text in
            XCTAssertEqual(text, "Languages")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenALanguageViewmodelWhenViewDidLoadThenVisibleItemsIsCorrectlyReturned() {
        let mockRepository = MockLanguageRepository()
        mockRepository.result = [Language(key: "Fr", title: "Français")]
        let delegate = MockLanguageViewControllerDelegate()
        let viewModel = LanguageViewModel(languageType: .origin,
                                          repository: mockRepository,
                                          delegate: delegate)
        let expectation = self.expectation(description: "Returned items")
        
        let expectedResult: [LanguageViewModel.Item] = [.language(text: "Français")]
        
        viewModel.visibleItems = { items in
            XCTAssertEqual(items, expectedResult)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenALanguageViewmodelWithOriginLanguageTypeWhenViewDidDidSelectitemAtAnExistingIndexThenDelegateIsCoreectlyCalled() {
        let mockRepository = MockLanguageRepository()
        mockRepository.result = [Language(key: "Fr", title: "Français")]
        let delegate = MockLanguageViewControllerDelegate()
        let viewModel = LanguageViewModel(languageType: .origin,
                                          repository: mockRepository,
                                          delegate: delegate)
        
        viewModel.viewDidLoad()
        
        viewModel.didSelectItem(at: 0)
        
        XCTAssertEqual(delegate.language, LanguageType.origin("Français", "Fr"))
    }
    
    func testGivenALanguageViewmodelWithDestinationLanguageTypeWhenViewDidDidSelectitemAtAnExistingIndexThenDelegateIsCoreectlyCalled() {
        let mockRepository = MockLanguageRepository()
        mockRepository.result = [Language(key: "Fr", title: "Français")]
        let delegate = MockLanguageViewControllerDelegate()
        let viewModel = LanguageViewModel(languageType: .destination,
                                          repository: mockRepository,
                                          delegate: delegate)
        
        viewModel.viewDidLoad()
        
        viewModel.didSelectItem(at: 0)
        
        XCTAssertEqual(delegate.language, LanguageType.destination("Français", "Fr"))
    }
    
    func testGivenALanguageViewmodeleWhenViewDidDidSelectitemAtAnUnexistingIndexThenDelegateIsNotCalled() {
        let mockRepository = MockLanguageRepository()
        mockRepository.result = [Language(key: "Fr", title: "Français")]
        let delegate = MockLanguageViewControllerDelegate()
        let viewModel = LanguageViewModel(languageType: .destination,
                                          repository: mockRepository,
                                          delegate: delegate)
        
        viewModel.viewDidLoad()
        
        viewModel.didSelectItem(at: 100000)
        
        XCTAssertNil(delegate.language)
    }
}

fileprivate final class MockLanguageRepository: LanguageRepositoryType {
    
    var result: [Language] = []
    
    func requestLanguages(callback: @escaping ([Language]) -> Void) {
        callback(result)
    }
}

fileprivate final class MockLanguageViewControllerDelegate: LanguageViewModelDelegate {
    
    var language: LanguageType? = nil
    
    func languageScreenDidSelectDetail(with language: LanguageType) {
        self.language = language
    }
}
