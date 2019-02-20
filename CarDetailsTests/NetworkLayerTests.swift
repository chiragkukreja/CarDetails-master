//
//  NetworkLayerTests.swift
//  CarDetailsTests
//
//  Created by Chirag Kukreja on 2/20/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit
import XCTest
@testable import CarDetails
class NetworkLayerTests: XCTestCase {    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testURLEncoding() {
        do {
            let request = try Router<CarApi>().buildRequest(from: .manufacturer(page: 0, pageSize: 10))
            
            let expectedURL = "http://api-aws-eu-qa-1.auto1-test.com/v1/car-types/manufacturer?page=0&pageSize=10&wa_key=coding-puzzle-client-449cc9d"
            XCTAssertEqual(request.url?.absoluteString.sorted(), expectedURL.sorted())
        } catch {
            
        }
        
    }
}
