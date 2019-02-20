//
//  CarDetailTableViewCell.swift
//  CarDetails
//
//  Created by Shrinivas on 2/18/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import UIKit

class CarDetailTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func showCell(_ title: String) {
        self.title.text = title
    }
}
