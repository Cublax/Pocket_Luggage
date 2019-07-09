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
    
    // MARK: - Properties
    
    var viewModel: TranslatorViewModel! // We assert that this is absolutly needed 🙌
    
    var textWrittenCopy = ""
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: TranslatorViewModel) {
        viewModel.traductedText = { [weak self] text in
            self?.TextFieldDestination.text = text
        }
    }
  
    // MARK: - Actions
    
    @IBAction func selectLanguage(_ sender: UIButton) {
        let index = sender.tag
        viewModel.didSelectLangForItem(at: index)
    }
    
    @IBAction func TranslateButton(_ sender: UIButton) {
        viewModel.didPressTranslate(for: TextFieldOrigin.text!, from: "en", to: "fr")
}
    
}
