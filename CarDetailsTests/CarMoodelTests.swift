//
//  CarDetailsTests.swift
//  CarDetailsTests
//
//  Created by Chirag Kukreja on 13/02/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import XCTest
@testable import CarDetails

class CarMoodelTests: XCTestCase, RouterDelegate {

    private var viewModel: CarModelViewModel!
    private var carModelExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        let detail = keyValuePair.init(id: "130", name: "BMW")
        viewModel = CarModelViewModel(apiService: Router<CarApi>(), manufacturerDetail: detail)
        viewModel.delegate = self
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testsModelList() {
        carModelExpectation = expectation(description: "Model List")
        viewModel.getCarModels()
        wait(for: [carModelExpectation], timeout: 10)
        XCTAssertTrue(viewModel.totalItems > 0)
    }
    func onFetchCompleted(indexpathsToInsert: [IndexPath]?) {
        carModelExpectation.fulfill()
    }
    func onFetchError() {
        carModelExpectation.fulfill()
    }
}
