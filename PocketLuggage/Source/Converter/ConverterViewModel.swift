//
//  ConverterViewModel.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 29/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol ConverterViewModelDelegate: class {
    func shouldDisplayAlert(for type: AlertType)
}

struct CurrencyConfiguration {
    var originCurrency: (currencyKey: String, rate: Double, amount: String)
    var destinationCurrency: (currencyKey: String, rate: Double, amount: String)

}

typealias CurrencyStructure = (currencyKey: String, rate: Double, amount: String)

final class ConverterViewModel {
    
    // MARK: - Properties
    
    private let repository: ConverterRepository
    
    private let currencyConfiguration: CurrencyConfiguration
    
    private weak var delegate: ConverterViewModelDelegate?
   
    private var rates: [String: Double] = [:]
    
    private var symbols: [String: String] = [:] {
        didSet {
            let value = self.symbols.map { $0.value }
            self.currencyItems?(value)
        }
    }
    
    private var currencyStructures: [CurrencyStructure] = [] {
        didSet {
            let origin = self.currencyStructures[0]
            originCurrencyTitleText?("\(origin.rate) \(origin.currencyKey)")
            originPlaceHolderText?(origin.amount)
            let destination = self.currencyStructures[1]
            destinationCurrencyTitleText?("\(destination.rate) \(destination.currencyKey)")
            destinationPlaceHolderText?(destination.amount)
        }
    }
    
    // MARK: - Initializer
    
    init(repository: ConverterRepository, currencyConfiguration: CurrencyConfiguration, delegate: ConverterViewModelDelegate?) {
        self.repository = repository
        self.currencyConfiguration = currencyConfiguration
        self.delegate = delegate
    }
    
    private func initializeCurrencyStructure(with configuration: CurrencyConfiguration) -> [CurrencyStructure] {
        return [CurrencyStructure(configuration.originCurrency.currencyKey, configuration.originCurrency.rate, configuration.originCurrency.amount),
            CurrencyStructure(configuration.destinationCurrency.currencyKey, configuration.destinationCurrency.rate, configuration.destinationCurrency.amount)]
    }
    // MARK: - Outputs
    
    var originCurrencyTitleText: ((String) -> Void)?

    var originPlaceHolderText: ((String) -> Void)?
    
    var destinationCurrencyTitleText: ((String) -> Void)?
    
    var destinationPlaceHolderText: ((String) -> Void)?
    
    var convertButtonTitleText: ((String) -> Void)?
    
    var currencyItems: (([String]) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        repository.getCurenciesList { (symbolsItem) in
            self.symbols = symbolsItem.symbols
        }
        repository.getCurrenciesRate { (currencyItem) in
            self.rates = currencyItem.rates
        }
        currencyStructures = initializeCurrencyStructure(with: self.currencyConfiguration)
    }
    
    func didSelectCurrency(for value: String) {
        var returnedKey: String = ""
        let values = self.symbols.map { $0.value }
        guard let index: Int = values.firstIndex(of: value) else { return }
        if index <= symbols.count {
            returnedKey = Array(symbols.keys)[index]
        }
        getRateForKey(for: returnedKey)
        self.currencyStructures[1].currencyKey = returnedKey
    }
    
    
    private func getRateForKey(for key: String) {
        var rate: Double = 0
        let keys = self.rates.map { $0.key }
        guard let index: Int = keys.firstIndex(of: key) else {return}
        if index <= rates.count {
            rate = Array(rates.values)[index]
        }
        self.currencyStructures[1].rate = rate
    }
    
    func getConvertion(for texFieldAmount: String) {
        self.currencyStructures[0].amount = texFieldAmount
        guard let x = Double(currencyStructures[0].amount) else {return}
        currencyStructures[1].amount = String(x * currencyStructures[1].rate)
    }
    
}


