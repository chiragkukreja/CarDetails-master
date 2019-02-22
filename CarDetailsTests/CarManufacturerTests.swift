//
//  CarManufacturerTests.swift
//  CarDetailsTests
//
//  Created by Chirag Kukreja on 2/20/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit
import XCTest

@testable import CarDetails

class CarManufacturerTests: XCTestCase, RouterDelegate {
    
    private var viewModel: CarManufacturerViewModel!
    private var manufacturerExpectation: XCTestExpectation!
    override func setUp() {
        super.setUp()
        viewModel = CarManufacturerViewModel(apiService: Router<CarApi>())
        viewModel.delegate = self       
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func testsManufacturerList() {
        manufacturerExpectation = expectation(description: "Manufacturer List")
        viewModel.getCarManufactures()
        wait(for: [manufacturerExpectation], timeout: 10)
        XCTAssertTrue(viewModel.totalItems > 0)
    }
    func onFetchCompleted(indexpathsToInsert: [IndexPath]?) {
         manufacturerExpectation.fulfill()
    }
    func onFetchError() {
        manufacturerExpectation.fulfill()
    }
}
