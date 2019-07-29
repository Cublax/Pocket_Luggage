//
//  TranslatorViewModelTests.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 25/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import PocketLuggage

enum MockedError: Error {
    case repositoryError
}


fileprivate final class MockTranslateRepository: TranslatorRepositoryType {
    
    var isSuccess = true
    var returnedText = ""
    
    func translateRequest(for text: String, from originLanguage: String, to destinationLanguage: String, callback: @escaping ((String?, Error?) -> Void)) {
        isSuccess ? callback(returnedText, nil) : callback(nil, MockedError.repositoryError)
    }
}

fileprivate final class MockTranslatorViewModelDelegate: TranslatorViewModelDelegate {
    var alert: AlertType? = nil
    
    var languagetype: LanguageViewType = .origin
    
    func didPresentLanguages(for type: LanguageViewType) {
        self.languagetype = type
    }
    
    func shouldDisplayAlert(for type: AlertType) {
        self.alert = type
    }
}

final class TranslatorViewModelTests: XCTestCase {
    
    func testGivenATranslatorViewModelWhenViewDidLoadThenOriginAndDestionationTextAndTextLanguageAreCorectlyReturned() {
        let mockRepository = MockTranslateRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let languageConfiguration = LanguageConfiguration(originLanguage: ("Francais", "fr", ""),
                                                          destinationLanguage: ("English", "en", ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository,
                                            languageConfiguration: languageConfiguration,
                                            delegate: mockDelegate)
        let expectation1 = self.expectation(description: "Returned empty text")
        let expectation2 = self.expectation(description: "Returned Text Language")
        let expectation3 = self.expectation(description: "Returned empty text")
        let expectation4 = self.expectation(description: "Returned Text Language")
        
        
        viewModel.originText = { text in
            XCTAssertEqual(text, "")
            expectation1.fulfill()
        }
        
        viewModel.originTextLanguague = { text in
            XCTAssertEqual(text, "Francais")
            expectation2.fulfill()
        }
        
        viewModel.destinationText = { text in
            XCTAssertEqual(text, "")
            expectation3.fulfill()
        }
        
        viewModel.destinationTextLanguage = { text in
            XCTAssertEqual(text, "English")
            expectation4.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenATranslatorViewModelWhenDidSelectLanguageThenLanguageTypeOriginIsCorrectlyReturned() {
        let mockRepository = MockTranslateRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let languageConfiguration = LanguageConfiguration(originLanguage: ("Francais", "fr", ""),
                                                          destinationLanguage: ("English", "en", ""))
        let viewModel = TranslatorViewModel(repository: mockRepository,
                                            languageConfiguration: languageConfiguration,
                                            delegate: mockDelegate)
        
        viewModel.viewDidLoad()
        
        viewModel.didSelectLang(for: LanguageViewType.origin)
        
        XCTAssertEqual(mockDelegate.languagetype, .origin)
    }
    
    func testGivenATranslatorViewModelWhenDidSelectLanguageThenLanguageTypeDestinationIsCorrectlyReturned() {
    let mockRepository = MockTranslateRepository()
    let mockDelegate = MockTranslatorViewModelDelegate()
    let languageConfiguration = LanguageConfiguration(originLanguage: ("Francais", "fr", ""),
    destinationLanguage: ("English", "en", ""))
    let viewModel = TranslatorViewModel(repository: mockRepository,
    languageConfiguration: languageConfiguration,
    delegate: mockDelegate)
    
    viewModel.viewDidLoad()
    
    viewModel.didSelectLang(for: LanguageViewType.destination)
    
    XCTAssertEqual(mockDelegate.languagetype, .destination)
    }
    
    func testGivenATranslatorViewModelWhenDidPressTranslateThenTraductionIsCorrectlyReturned() {
        let mockRepository = MockTranslateRepository()
        let languageConfiguration = LanguageConfiguration(originLanguage: ("Francais", "fr", ""),
                                                          destinationLanguage: ("English", "en", ""))
        let viewModel = TranslatorViewModel(repository: mockRepository, languageConfiguration: languageConfiguration, delegate: nil)
        mockRepository.isSuccess = true
        mockRepository.returnedText = "Hello"
        let expectation = self.expectation(description: "Returned text")
        
        var counter = 0
        viewModel.destinationText = { text in
            if counter == 2 {
                XCTAssertEqual(text, "Hello")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didPressTranslate(for: "Bonjour")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenATranslatorViewModelWhenDidPressTranslateThenGetAnError() {
        let mockRepository = MockTranslateRepository()
        let mockDelegate = MockTranslatorViewModelDelegate()
        let languageConfiguration = LanguageConfiguration(originLanguage: ("Francais", "fr", ""),
                                                          destinationLanguage: ("English", "en", ""))
        let viewModel = TranslatorViewModel(repository: mockRepository,
                                            languageConfiguration: languageConfiguration,
                                            delegate: mockDelegate)
        mockRepository.isSuccess = false
        
        viewModel.viewDidLoad()
        
        viewModel.didPressTranslate(for: "Bonjour")
        
        XCTAssertEqual(mockDelegate.alert, .translationError)
    }
    
    func testGivenATranslatorViewModelWhenDidPressSwitchThenTranslatedIsCorrectlyCopiedInTranslation() {
        let mockRepository = MockTranslateRepository()
        mockRepository.returnedText = "Hello"
        let mockDelegate = MockTranslatorViewModelDelegate()
        let languageConfiguration = LanguageConfiguration(originLanguage: ("Francais", "fr", ""),
                                                          destinationLanguage: ("English", "en", ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository,
                                            languageConfiguration: languageConfiguration,
                                            delegate: mockDelegate)
        let expectation1 = self.expectation(description: "Returned text")
        let expectation2 = self.expectation(description: "Returned text")
        
        
        var counter = 0
        viewModel.destinationText = { text in
            if counter == 5 {
                XCTAssertEqual(text, "Coucou")
                expectation1.fulfill()
            }
            counter += 1
        }
        
        var ccounter = 0
        viewModel.destinationTextLanguage = { text in
            if ccounter == 5 {
                XCTAssertEqual(text, "Francais")
                expectation2.fulfill()
            }
            ccounter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didPressTranslate(for: "Coucou")
        
        viewModel.didPressSwitch(with: "Coucou", and: "Hello")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenATranslatorViewModelWhenDidPressSwitchThenTranslationIsCorrectlyCopiedInTranslated() {
        let mockRepository = MockTranslateRepository()
        mockRepository.returnedText = "Hello"
        let mockDelegate = MockTranslatorViewModelDelegate()
        let languageConfiguration = LanguageConfiguration(originLanguage: ("Francais", "fr", ""),
                                                          destinationLanguage: ("English", "en", ""))
        
        let viewModel = TranslatorViewModel(repository: mockRepository,
                                            languageConfiguration: languageConfiguration,
                                            delegate: mockDelegate)
        let expectation1 = self.expectation(description: "Returned text")
        let expectation2 = self.expectation(description: "Returned text")
        
        
        var counter = 0
        viewModel.originText = { text in
            if counter == 5 {
                XCTAssertEqual(text, "Hello")
                expectation1.fulfill()
            }
            counter += 1
        }
        
        var ccounter = 0
        viewModel.originTextLanguague = { text in
            if ccounter == 5 {
                XCTAssertEqual(text, "English")
                expectation2.fulfill()
            }
            ccounter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didPressTranslate(for: "Coucou")
        
        viewModel.didPressSwitch(with: "Coucou", and: "Hello")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
