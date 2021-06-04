//
//  ViewController.swift
//  Project
//
//  Created by danh on 5/29/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.saveFireData()
    }
    func saveFireData(){
        let dict = ["name":"Tra Dao","Price":"20"]
        self.ref.child("Coffee").child("Product1").setValue(dict)
    }

}

