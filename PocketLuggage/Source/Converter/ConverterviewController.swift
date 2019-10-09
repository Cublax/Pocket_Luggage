//
//  ConverterviewController.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class ConverterViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var originUnityCurrencyLabel: UILabel!
    
    @IBOutlet weak var originCurrencyTextField: UITextField!
    
    @IBOutlet weak var convertButton: UIButton!
    
    @IBOutlet weak var destinationUnityCurrencyLabel: UILabel!
    
    @IBOutlet weak var destinationCurrencyTextField: UITextField!

    @IBOutlet weak var destinationCurrencyPickerView: UIPickerView!
    
    
    // MARK: - Properties
    
    var viewModel: ConverterViewModel!
    
    private lazy var dataSource = ConverterDataSource()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destinationCurrencyPickerView.dataSource = dataSource
        destinationCurrencyPickerView.delegate = dataSource
        
        bind(to: dataSource)
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: ConverterViewModel) {
        viewModel.originCurrencyTitleText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originUnityCurrencyLabel.text = text
            }
        }

        viewModel.originText = { [weak self] number in
            DispatchQueue.main.async {
                self?.originCurrencyTextField.text = number
            }
        }
        
        viewModel.originPlaceHolderText = { [weak self] number in
            DispatchQueue.main.async {
                self?.originCurrencyTextField.placeholder = number
            }
        }

        viewModel.destinationCurrencyTitleText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationUnityCurrencyLabel.text = text
            }
        }
        
        viewModel.destinationText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationCurrencyTextField.text = text
            }
        }
        
        viewModel.destinationPlaceHolderText = { [weak self] number in
            DispatchQueue.main.async {
                self?.destinationCurrencyTextField.placeholder = number
            }
        }
        
        viewModel.currencyTitles = { [weak self] items in
            DispatchQueue.main.async {
                self?.dataSource.update(with: items)
                self?.destinationCurrencyPickerView.reloadAllComponents()
            }
        }
    }
    
    private func bind(to datasource: ConverterDataSource) {
       dataSource.didSelectCurrencyAtIndex = viewModel.didSelectCurrency
    }
    
    // MARK: - Actions
    
    @IBAction func convert(_ sender: UIButton) {
        guard let value = originCurrencyTextField.text else {return}
        viewModel.didPressConvert(value: value)
    }
}
