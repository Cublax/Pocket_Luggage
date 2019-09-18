//
//  ConverterDataSource.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 30/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class ConverterDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - Properties
 
    private var visibleItems: [String] = []
    
    // MARK: - Public func
    
    func update(with countryItems: [String]) {
        self.visibleItems = countryItems.sorted()
    }
    
    // MARK: - UIPIckerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return visibleItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row < visibleItems.count else { return nil }
        return self.visibleItems[row]
    }
    
    // MARK: - UIPIckerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < visibleItems.count else { return }
        didSelectCurrencyAtIndex?(row)
    }
    
    // MARK: - Public
    
    var didSelectCurrencyAtIndex: ((Int) -> Void)?
}

