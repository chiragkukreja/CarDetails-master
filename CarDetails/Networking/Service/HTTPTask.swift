//
//  HTTPTask.swift
//  MyTaxi
//
//  Created by Chirag Kukreja on 09/02/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import Foundation

 typealias HTTPHeaders = [String:String]

 enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    // case download, upload...etc
}

