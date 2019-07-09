//
//  LanguagesTableViewCell.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 13/06/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class LanguageTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Configure
    
    func configure(with title: String, isSelected: Bool) {
        self.nameLabel.text = title
        self.accessoryType = isSelected ? .checkmark : .none
    }
}
