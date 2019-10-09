//
//  LanguageDataSource.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 03/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

class LanguageDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    typealias Item  = LanguageViewModel.Item
    
    // MARK: - Private

    private enum VisibleItem {
        case item(language: String)
    }
    
    private var items: [VisibleItem] = []
    
    // MARK: - Public
    
    var didSelectItemAtIndex: ((Int) -> Void)?
    
    func update(with items: [Item]) {
        self.items = items.map { item -> VisibleItem  in
            switch item {
            case .language(text: let text):
                return .item(language: text)
            }
        }
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.item < items.count else {
            fatalError("Index out of range")
        }
        
        switch items[indexPath.item] {
        case .item(language: let language):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! LanguageTableViewCell
            cell.configure(with: language)
            return cell
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item < items.count else {
            assertionFailure("Index out of Range")
            return
        }
        
        let index = indexPath.item
        didSelectItemAtIndex?(index)
    }
}


