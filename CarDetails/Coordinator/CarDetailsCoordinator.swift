//
//  CarDetailsCoordinator.swift
//  CarDetails
//
//  Created by Chirag Kukreja on 2/20/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit

protocol BaseCoordinatorProtocol: class {
    var navigationController: UINavigationController? {get set}
    init(_ fromController: UINavigationController?)
}

class BaseCoordinator: BaseCoordinatorProtocol {
    var navigationController: UINavigationController?
    required init(_ fromController: UINavigationController? = nil) {
        self.navigationController = fromController
    }
}

final  class CarModelCoordionator: BaseCoordinator {
    func showCarModels(_ manufacturer: keyValuePair) {
        let viewController: CarModelsViewViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CarModelsViewViewController") as! CarModelsViewViewController
        let viewModel = CarModelViewModel(apiService: Router<CarApi>(), manufacturerDetail: manufacturer)
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
}
