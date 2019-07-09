//
//  LanguagesViewController.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class LanguagesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Privates var
    
    var viewModel: LanguageViewModel!
    
    private let dataSource = LanguageDataSource()

    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        bind(to: dataSource)
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
    }
    
    private func bind(to source: LanguageDataSource) {
       dataSource.didSelectItemAtIndex = viewModel.didSelectItem
    }
    
    private func bind(to: LanguageViewModel) {
        
        viewModel.titleText = { [weak self] text in
            self?.navigationItem.title = text
        }
        
        viewModel.visibleItems = { [weak self] items in
            DispatchQueue.main.async {
                self?.dataSource.update(with: items)
                self?.tableView.reloadData()
            }
        }
        
    }
    
}
