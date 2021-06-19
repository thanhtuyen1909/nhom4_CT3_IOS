//
//  ProfileCell.swift
//  Project
//
//  Created by Chun on 6/19/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    // MARK: - properties
    
    @IBOutlet weak var profileFuncImg: UIImageView!
    @IBOutlet weak var profileFuncTitle: UILabel!
    @IBOutlet weak var profileNextFunc: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
