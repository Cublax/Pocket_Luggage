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
    
    @IBOutlet weak var TextFieldOrigin: UITextField!
    
    @IBOutlet weak var TextFieldDestination: UITextField!
    
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
            self?.originLanguageButton.setTitle(text, for: .normal)
        }
        
        viewModel.destinationTextLanguage = { [weak self] text in
            self?.destinationLanguageButton.setTitle(text, for: .normal)
        }
        
        viewModel.traductedText = { [weak self] text in
            DispatchQueue.main.async {
                self?.TextFieldDestination.text = text
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
    
    
    @IBAction func TranslateButton(_ sender: UIButton) {
        viewModel.didPressTranslate(for: TextFieldOrigin.text!)
}
    
}
