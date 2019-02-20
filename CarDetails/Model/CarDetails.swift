//
//  CarDetails.swift
//  CarDetails
//
//  Created by Chirag Kukreja on 13/02/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import Foundation

struct CarDetails: Codable {
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let data: [String: String]

    private enum CodingKeys: String, CodingKey {
        case page
        case pageSize = "pageSize"
        case totalPages = "totalPageCount"
        case data = "wkda"
    }
    
    func customData() -> [keyValuePair] {
        var array = [keyValuePair]()
        for (key, value) in data {
            let d = keyValuePair(id: key, name: value)
            array.append(d)
        }
        return array
    }
}

struct keyValuePair {
    let id: String
    let name: String
}
