//
//  CarModelsViewViewController.swift
//  CarDetails
//
//  Created by Chirag Kukreja on 2/18/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit

class CarModelsViewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: CarModelViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Car Models"
        tableView.register(CarDetailTableViewCell.self)
        viewModel.getCarModels()
    }
}
extension CarModelsViewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.showCell(viewModel.item(at: indexPath).name)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.backgroundColor = UIColor.lightText
        }
        cell.selectionStyle = .none
        if indexPath.row  == viewModel.totalItems - 4 {
            viewModel.getCarModels()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = UIAlertAction.init(title: "OK", style: .default)
        displayAlert(with: "Selection", message: viewModel.getMessage(indexPath), actions: [action])
    }
}

extension CarModelsViewViewController: RouterDelegate {
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
        let action = UIAlertAction.init(title: "OK", style: .default)
        displayAlert(with: "Error", message: "Unable to get details", actions: [action])
    }
}
