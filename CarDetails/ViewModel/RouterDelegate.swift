//
//  RouterDelegate.swift
//  CarDetails
//
//  Created by Chirag Kukreja on 13/02/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit

protocol RouterDelegate: class {
    func onFetchCompleted(indexpathsToInsert: [IndexPath]?)
    func onFetchError()
}
