//
//  CarModelViewModel.swift
//  CarDetails
//
//  Created by Chirag Kukreja on 2/18/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit
class CarModelViewModel {
    var delegate: RouterDelegate?
    let router: Router<CarApi>
    private var page = 0
    private var pageSize = 15
    private var totalPages = 1
    private var manufacturer: keyValuePair
    private var carModels = [keyValuePair]()
    private var isApiInProgress = false
    var totalItems: Int {
        return carModels.count
    }
    init(apiService: Router<CarApi>, manufacturerDetail:keyValuePair) {
        self.router = apiService
        self.manufacturer = manufacturerDetail
    }
    func item(at indexpath: IndexPath) -> keyValuePair {
        return carModels[indexpath.row]
    }
     // This function first check  whether current page size is less than the total number of the pages ,then makes an api call to get all the manufacturers and increments the page size
    func getCarModels() {
        guard  !isApiInProgress, page < totalPages else {return}
        isApiInProgress = true
        router.request(.model(maufacturerId: manufacturer.id, page: page, pageSize: pageSize), mapToModel: CarDetails.self, onSuccess: { [weak self] (data) in
            guard let `self` = self else {return}
            self.page += 1
            self.totalPages = data.totalPages
            self.isApiInProgress = false
            let newResult = data.customData()
            self.carModels.append(contentsOf: newResult)
            if self.page == 1 {
                self.delegate?.onFetchCompleted(indexpathsToInsert: .none)
            }else {
                self.delegate?.onFetchCompleted(indexpathsToInsert: self.calculateIndexPathsToInsert(from: newResult))
            }
        }) { [weak self] (error) in
            guard let `self` = self else {return}
            self.isApiInProgress = false
            self.delegate?.onFetchError()
        }
    }
    func getMessage(_ indexPath: IndexPath) -> String {
        return "\(manufacturer.name) - \(item(at: indexPath).name)"
    }
    // This function will calculate the indexpath of the row which needs to be inserted in tableview
    private func calculateIndexPathsToInsert(from newResults: [keyValuePair]) -> [IndexPath] {
        let startIndex = self.carModels.count - newResults.count
        let endIndex = startIndex + newResults.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
