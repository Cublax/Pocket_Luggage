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
    
    // MARK: - Properties
    
    var viewModel: TranslatorViewModel! // We assert that this is absolutly needed 🙌
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: TranslatorViewModel) {
        
    }
    
    // MARK: - Actions
    
    @IBAction func selectLang(_ sender: UIButton) {
        let index = sender.tag
        viewModel.didSelectLangForItem(at: index)
    }
}
