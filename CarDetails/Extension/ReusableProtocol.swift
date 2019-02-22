//
//  ReusableProtocol.swift
//  CarDetails
//
//  Created by Chirag Kukreja on 2/20/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var defaultReuseIdentifier: String { get }
    static var nibName: String { get }
}
extension Reusable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    static var nibName: String {
        return String(describing: self)
    }
}
extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}
