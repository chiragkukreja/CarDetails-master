//
//  CarManufacturerViewModel.swift
//  CarDetails
//
//  Created by Chirag Kukreja on 13/02/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit

class CarManufacturerViewModel: NSObject {
    var delegate: RouterDelegate?
    private let router: Router<CarApi>
    private var page = 0
    private var pageSize = 15
    private var totalPages = 1
    private var manufactures = [keyValuePair]()
    private var isApiInProgress = false
    var totalItems: Int {
        return manufactures.count
    }
    init(apiService: Router<CarApi>) {
        self.router = apiService
    }
    func item(at indexpath: IndexPath) -> keyValuePair {
        return manufactures[indexpath.row]
    }
    // This function first check  whether current page size is less than the total number of the pages ,then makes an api call to get all the manufacturers and increments the page size
    func getCarManufactures() {
        guard  !isApiInProgress, page < totalPages else {return}
        isApiInProgress = true
        router.request(.manufacturer(page: page, pageSize: pageSize), mapToModel: CarDetails.self, onSuccess: { [weak self] (data) in
            guard let `self` = self else {return}
            self.page += 1
            self.totalPages = data.totalPages
            self.isApiInProgress = false
            let newResult = data.customData()
            self.manufactures.append(contentsOf:newResult)
            if self.page == 1 {
                self.delegate?.onFetchCompleted(indexpathsToInsert: .none)
            }else {
            self.delegate?.onFetchCompleted(indexpathsToInsert: self.calculateIndexPathsToInsert(from: newResult))
            }
        }) {[weak self] (error) in
            guard let `self` = self else {return}
            self.isApiInProgress = false
            self.delegate?.onFetchError()
        }
    }
   // This function will calculate the indexpath of the row which needs to be inserted in tableview
    private func calculateIndexPathsToInsert(from newResults: [keyValuePair]) -> [IndexPath] {
        let startIndex = self.manufactures.count - newResults.count
        let endIndex = startIndex + newResults.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
