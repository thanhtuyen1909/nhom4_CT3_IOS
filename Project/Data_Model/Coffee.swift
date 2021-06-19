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
    var coffeeImage : String
    var coffeePrice : Int
    
    // MARK: - contructors
    init() {
        self.coffeeName = ""
        self.coffeeImage = ""
        self.coffeePrice = 0
    }
    
    init?(coffeeName:String, coffeeImage:String, coffeePrice:Int) {
        if(coffeeName.isEmpty == true || coffeePrice < 0 || coffeeImage.isEmpty == true){
            return nil
        }
        self.coffeeName = coffeeName
        self.coffeeImage = coffeeImage
        self.coffeePrice = coffeePrice
    }
}
