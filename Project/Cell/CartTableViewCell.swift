//
//  CartTableViewCell.swift
//  Project
//
//  Created by danh on 6/20/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    // MARK: properties
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartName: UILabel!
    @IBOutlet weak var cartPrice: UILabel!
    @IBOutlet weak var cartQuantity: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnSub: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
