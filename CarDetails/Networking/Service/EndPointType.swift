//
//  EndPointType.swift
//  MyTaxi
//
//  Created by Chirag Kukreja on 09/02/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
