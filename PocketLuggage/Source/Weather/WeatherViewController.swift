//
//  MeteoViewController.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class MeteoViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var weatherTableView: UITableView!

    // MARK: Private var
    
    var viewModel: MeteoViewModel!

    private let datasource = MeteoDataSource()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Weather"
        
        weatherTableView.dataSource = datasource
        weatherTableView.delegate = datasource
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: MeteoViewModel) {
        viewModel.items = { [weak self] items in
            self?.datasource.update(with: items)
            self?.weatherTableView.reloadData()
        }
    }
}
