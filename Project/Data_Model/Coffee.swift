//
//  Coffee.swift
//  Project
//
//  Created by danh on 6/7/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
class Coffee {
    var coffeeName : String
    var coffeeImage : UIImage? = nil
    var coffeePrice : Int
    init(coffeeName:String,coffeeImage:UIImage,coffeePrice:Int) {
        self.coffeeName = coffeeName
        self.coffeeImage = coffeeImage
        self.coffeePrice = coffeePrice
    }
    init() {
        self.coffeeName = ""
        self.coffeePrice = 0
    }
}
