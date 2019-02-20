//
//  EndPoint.swift
//  MyTaxi
//
//  Created by Chirag Kukreja on 09/02/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit

enum CarApi {
    case manufacturer(page: Int, pageSize: Int)
    case model(maufacturerId: String, page: Int, pageSize: Int)
}

struct Constant {
    static let key = "coding-puzzle-client-449cc9d"
}
extension CarApi: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "http://api-aws-eu-qa-1.auto1-test.com") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .manufacturer:
            return "v1/car-types/manufacturer"
            
        case .model:
            return "v1/car-types/main-types"
            
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .manufacturer(let page, let pageSize):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page": page,
                                                      "pageSize": pageSize,
                                                      "wa_key": Constant.key])
        case .model(let id, let page, let pageSize):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["manufacturer": id,
                                                      "page": page,
                                                      "pageSize": pageSize,
                                                      "wa_key": Constant.key])
            
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
