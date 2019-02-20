//
//  ViewController.swift
//  CarDetails
//
//  Created by Chirag Kukreja on 13/02/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit

class CarManufacturerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel: CarManufacturerViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Manufacturers"
        viewModel = CarManufacturerViewModel.init(apiService: Router<CarApi>())
        viewModel.delegate = self
        activityIndicator.startAnimating()
        viewModel.getCarManufactures()
        tableView.register(CarDetailTableViewCell.self)
    }
}

extension CarManufacturerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.totalItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.showCell(viewModel.item(at: indexPath).name)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.backgroundColor = UIColor.gray
        }
        cell.selectionStyle = .none
        if indexPath.row  == viewModel.totalItems - 4 {
            viewModel.getCarManufactures()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.item(at: indexPath)
        CarModelCoordionator.init(self.navigationController).showCarModels(item)
    }
}

extension CarManufacturerViewController: RouterDelegate {
    func onFetchCompleted(indexpathsToInsert: [IndexPath]?) {
        if let indexpaths = indexpathsToInsert {
            tableView.beginUpdates()
            tableView.insertRows(at: indexpaths, with: .automatic)
            tableView.endUpdates()
        } else {
            tableView.reloadData()
        }
    }
    
    func onFetchError() {
        
    }
}
