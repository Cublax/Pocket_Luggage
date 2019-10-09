//
//  TranslatorViewController.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var originTextField: UITextField!
    
    @IBOutlet weak var destinationTextField: UITextField!
    
    @IBOutlet weak var originLanguageButton: UIButton!
    
    @IBOutlet weak var destinationLanguageButton: UIButton!
    
    // MARK: - Properties
    
    var viewModel: TranslatorViewModel! // We assert that this is absolutly needed 🙌
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: TranslatorViewModel) {
        viewModel.originTextLanguague = { [weak self] text in
            DispatchQueue.main.async {
                self?.originLanguageButton.setTitle(text, for: .normal)
            }
        }
        
        viewModel.destinationTextLanguage = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationLanguageButton.setTitle(text, for: .normal)
            }
        }
        
        viewModel.originText = { [weak self] text in
            DispatchQueue.main.async {
                self?.originTextField.text = text
            }
        }
        
        viewModel.destinationText = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationTextField.text = text
            }
        }
    }
  
    // MARK: - Actions
    
    @IBAction func selectSourceLanguage(_ sender: UIButton) {
        viewModel.didSelectLang(for: .origin)
    }
    
    @IBAction func selectTargetLanguage(_ sender: UIButton) {
        viewModel.didSelectLang(for: .destination)
    }
    
    @IBAction func translateButton(_ sender: UIButton) {
        viewModel.didPressTranslate(for: originTextField.text!)
    }
    
    @IBAction func switchButton(_ sender: UIButton) {
       viewModel.didPressSwitch(with: originTextField.text, and: destinationTextField.text)
    }
}
