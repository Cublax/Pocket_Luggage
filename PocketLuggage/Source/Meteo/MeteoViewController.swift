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

    @IBOutlet weak var tableView: UITableView!

    // MARK: Private var
    
    var viewModel: MeteoViewModel!

    private let datasource = MeteoDataSource()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = datasource
        tableView.delegate = datasource
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: MeteoViewModel) {
        viewModel.weatherItems = { [weak self] items in
            DispatchQueue.main.async {
                self?.datasource.update(with: items)
                self?.tableView.reloadData()
            }
        }
    }
}
