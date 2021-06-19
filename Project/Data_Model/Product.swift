//
//  Product.swift
//  Project
//
//  Created by Chun on 6/19/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
class Product {
    var productName : String
    var productAmount : Int
    var productPrice : Int
    
    // MARK: - contructors
    init() {
        self.productName = ""
        self.productAmount = 0
        self.productPrice = 0
    }
    
    init?(productName:String, productAmount:Int, productPrice:Int) {
        if(productName.isEmpty == true || productAmount < 0 || productPrice < 0){
            return nil
        }
        self.productName = productName
        self.productAmount = productAmount
        self.productPrice = productPrice
    }
}
