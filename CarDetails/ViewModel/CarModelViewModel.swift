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
    private var totalPages = 0
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
    func getCarModels() {
        guard  !isApiInProgress, page <= totalPages else {return}
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
    private func calculateIndexPathsToInsert(from newResults: [keyValuePair]) -> [IndexPath] {
        let startIndex = self.carModels.count - newResults.count
        let endIndex = startIndex + newResults.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
