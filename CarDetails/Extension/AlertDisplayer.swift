//
//  AlertDisplayer.swift
//  CarDetails
//
//  Created by Chirag Kukreja on 2/20/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit

extension UIViewController {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
}
