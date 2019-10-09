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

class CurrencyStructure {
    let title: String
    let shortTitle: String
    var value: Double
    
    init(title: String, shortTitle: String, value: Double) {
        self.title = title
        self.shortTitle = shortTitle
        self.value = value
    }
}

final class ConverterViewModel {
    
    // MARK: - Properties
    
    private let repository: ConverterRepositoryType
    
    private weak var delegate: ConverterViewModelDelegate?
    
    private var currencies: [CurrencyStructure] = [] {
        didSet {
            currencyTitles?(currencies.map {$0.title})
        }
    }

    private var localSelectedCurrency: CurrencyStructure?

    private var localValueToConvert: Double?
    
    // MARK: - Initializer
    
    init(repository: ConverterRepositoryType, delegate: ConverterViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Outputs
    
    var originCurrencyTitleText: ((String) -> Void)?
    
    var originText: ((String) -> Void)?
    
    var originPlaceHolderText: ((String) -> Void)?
    
    var destinationCurrencyTitleText: ((String) -> Void)?
    
    var destinationPlaceHolderText: ((String) -> Void)?
    
    var destinationText: ((String) -> Void)?
    
    var convertButtonTitleText: ((String) -> Void)?
    
    var currencyTitles: (([String]) -> Void)?
        
    func viewDidLoad() {
        originCurrencyTitleText?("1 EUR")
        originText?("")
        originPlaceHolderText?("0")
        
        destinationCurrencyTitleText?("")
        destinationText?("")
        destinationPlaceHolderText?("0")
        
        repository.getCurenciesList { (symbolsItem) in
            self.repository.getCurrenciesRate { (rateItem) in
                self.currencies = self.initialize(with: symbolsItem.symbols, and: rateItem.rates)
                self.localSelectedCurrency = self.currencies.first
                self.destinationCurrencyTitleText?("\(self.currencies.first?.value ?? 0.0) \(self.currencies.first?.shortTitle ?? "N/A")")
            }
        }
    }
    
    // MARK: - Inputs
    
    func initialize(with symbols: [String: String], and rates: [String: Double]) -> [CurrencyStructure] {
        let ordinate = symbols.sorted { $0.value < $1.value }
        let currencies: [CurrencyStructure] = ordinate.map { return CurrencyStructure(title: $0.value, shortTitle: $0.key, value: 0.0) }
        rates.forEach { key, value in
            currencies.forEach {
                if $0.shortTitle == key {
                    $0.value = value
                }
            }
        }
        return currencies
    }
    
    func didSelectCurrency(at index: Int) {
        guard index < currencies.count else { return }
        let selectedCurrency = currencies[index]
        localSelectedCurrency = selectedCurrency
        destinationCurrencyTitleText?("\(selectedCurrency.value) \(selectedCurrency.shortTitle)")
        guard let value = localValueToConvert else { return }
        convert(value: value)
    }
    
    func didPressConvert(value: String) {
        guard let doubleValue = Double(value) else {return}
        localValueToConvert = doubleValue
        convert(value: doubleValue)
    }

    private func convert(value: Double) {
        guard let selectedCurrencyValue = localSelectedCurrency?.value else { return }
        let result = value * selectedCurrencyValue
        destinationText?(String(result))
    }
}
