//
//  ConverterViewModelTests.swift
//  PocketLuggageTests
//
//  Created by Alexandre Quiblier on 28/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import XCTest
@testable import PocketLuggage


fileprivate final class MockConverterRepository: ConverterRepositoryType {
    
     var rateResult: CurrencyItem!
    
    func getCurrenciesRate(success: @escaping (CurrencyItem) -> Void, failure: @escaping (() -> Void)) {
        success(rateResult)
    }
    
    var symbolsResult: SymbolsItem!
       
    func getCurenciesList(success: @escaping (SymbolsItem) -> Void, failure: @escaping (() -> Void)) {
        success(symbolsResult)
    }
}

fileprivate final class MockConverterDelegate: ConverterViewModelDelegate {
    
    var alert: AlertType? = nil
    
    func shouldDisplayAlert(for type: AlertType) {
        self.alert = type
    }
}

final class ConverterViewModelTests: XCTestCase {
    
    func testGivenAConverterViewModelWhenViewDidLoadThenReactVarsAreCorrectlyFilledUp() {
        let mockRepository = MockConverterRepository()
        mockRepository.symbolsResult = SymbolsItem(symbols: ["USD": "Dolars"])
        mockRepository.rateResult = CurrencyItem(date: "toto", rates: ["USD": 123.0])
        
        let mockdelegate = MockConverterDelegate()
        let viewModel = ConverterViewModel(repository: mockRepository, delegate: mockdelegate)
        
        let expectation1 = self.expectation(description: "originPlaceHolder return 0")
        let expectation2 = self.expectation(description: "destinationPlaceHolder return 0")
        let expectation3 = self.expectation(description: "origin text return an empty String")
        let expectation4 = self.expectation(description: " destination text return an empty string")
        let expectation5 = self.expectation(description: "destinationCurrencyTitleText is default return")
        
        viewModel.originPlaceHolderText = { text in
            XCTAssertEqual(text, "0")
            expectation1.fulfill()
        }
        
        viewModel.destinationPlaceHolderText = { text in
            XCTAssertEqual(text, "0")
            expectation2.fulfill()
        }
        
        viewModel.originText = { text in
            XCTAssertEqual(text, "")
            expectation3.fulfill()
        }
        
        viewModel.destinationText = { text in
            XCTAssertEqual(text, "")
            expectation4.fulfill()
        }
        
        // D'ou vient le .0 ??"
        var counter = 0
        viewModel.destinationCurrencyTitleText = { text in
            if counter == 1 {
            XCTAssertEqual(text, "123.0 USD")
            expectation5.fulfill()
        }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
   
    
    func testGivenAViewModelWhenUseInitializeFuncThenCurrencyTitlesAreCorrectlyReturned() {
        let mockRepository = MockConverterRepository()
        mockRepository.symbolsResult = SymbolsItem(symbols: ["USD" : "Dolars", "AUD" : "Australian Dollar"])
        mockRepository.rateResult = CurrencyItem(date: "toto", rates: ["USD" : 123, "AUD" : 123])
        let mockdelegate = MockConverterDelegate()
        let viewModel = ConverterViewModel(repository: mockRepository, delegate: mockdelegate)
        
        let expectation = self.expectation(description: "currencyTitles is correctly returned")
        
        viewModel.currencyTitles = { currency in
            XCTAssertEqual(currency, ["Australian Dollar", "Dolars"])
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
       
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testGivenAConverterViewModelWhenViewDidLoadThenReturnDefaultValue() {
        let mockRepository = MockConverterRepository()
        mockRepository.symbolsResult = SymbolsItem(symbols: [:])
        mockRepository.rateResult = CurrencyItem(date: "toto", rates: [:])
        let mockdelegate = MockConverterDelegate()
        let viewModel = ConverterViewModel(repository: mockRepository, delegate: mockdelegate)
        
        let expectation = self.expectation(description: "currencyTitles returns default value")
        
        var counter = 0
        viewModel.destinationCurrencyTitleText = { currency in
            if counter == 1 {
                XCTAssertEqual(currency, "0.0 N/A")
                expectation.fulfill()
            }
            counter += 1
        }

        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAConverterViewModelWhenDidPressConvertThenReturnTheConvertion() {
        let mockRepository = MockConverterRepository()
        mockRepository.symbolsResult = SymbolsItem(symbols: ["USD" : "Dolars"])
        mockRepository.rateResult = CurrencyItem(date: "toto", rates: ["USD" : 2])
        let mockdelegate = MockConverterDelegate()
        let viewModel = ConverterViewModel(repository: mockRepository, delegate: mockdelegate)
        
        let expectation = self.expectation(description: "COnvertion is correctly returned")
        
        var counter = 0
        viewModel.destinationText = { convertion in
            if counter == 1 {
                XCTAssertEqual(convertion, "20.0")
                expectation.fulfill()
            }
           counter += 1
        }
        
        viewModel.viewDidLoad()
        viewModel.didPressConvert(value: "10")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAConverterViewModelWhenDidPressConvertWithAbsurdThenReturn() {
    let mockRepository = MockConverterRepository()
    mockRepository.symbolsResult = SymbolsItem(symbols: ["USD" : "Dolars"])
    mockRepository.rateResult = CurrencyItem(date: "toto", rates: ["USD" : 2])
    let mockdelegate = MockConverterDelegate()
    let viewModel = ConverterViewModel(repository: mockRepository, delegate: mockdelegate)
    
    let expectation = self.expectation(description: "Convertion escape threw guard and destionationText return an empty String")
    
    viewModel.destinationText = { convertion in
    XCTAssertEqual(convertion, "")
    expectation.fulfill()
    }
    
    viewModel.viewDidLoad()
    viewModel.didPressConvert(value: "pomme")
    waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testGivenAConverterViewModelWhenDidSelectCurrencyThen() {
        let mockRepository = MockConverterRepository()
        mockRepository.symbolsResult = SymbolsItem(symbols: ["USD" : "Dolars"])
        mockRepository.rateResult = CurrencyItem(date: "toto", rates: ["USD" : 2])
        let mockdelegate = MockConverterDelegate()
        let viewModel = ConverterViewModel(repository: mockRepository, delegate: mockdelegate)
        
        let expectation1 = self.expectation(description: " destinationText is correctly returned ")
        let expectation2 = self.expectation(description: "destinationCurrencyTitleText is correctly returned")
        
        var counter = 0
        viewModel.destinationCurrencyTitleText = { text in
            if counter == 2 {
                XCTAssertEqual(text, "2.0 USD")
                expectation2.fulfill()
            }
            counter += 1
        }
        
        viewModel.destinationText = { convertion in
            if counter == 2 {
                XCTAssertEqual(convertion, "20.0")
                expectation1.fulfill()
            }
        }
        
        viewModel.viewDidLoad()
        viewModel.didPressConvert(value: "10") // meilleure facon de remplir localValueToConvert?
        viewModel.didSelectCurrency(at: 0)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
