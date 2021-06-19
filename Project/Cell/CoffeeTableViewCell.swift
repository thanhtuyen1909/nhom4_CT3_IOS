//
//  CoffeeTableViewCell.swift
//  Project
//
//  Created by danh on 6/7/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {

    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
