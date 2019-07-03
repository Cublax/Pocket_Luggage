//
//  AlertDisplay.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 02/07/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

extension UIView {
 func displayAlert(with title: String, message: String, actionTitle: String) {
    let alertController = UIAlertController()
    alertController.title = title
    alertController.message = message
    let action = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
    alertController.addAction(action)
    self.show(alertController, sender: nil)
}
}
