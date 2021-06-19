//
//  WareHouseCell.swift
//  Project
//
//  Created by Chun on 6/19/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit

class WareHouseCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productAmount: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
