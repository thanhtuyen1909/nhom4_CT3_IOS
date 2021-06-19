//
//  ViewController.swift
//  Project
//
//  Created by danh on 5/29/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    
    @IBAction func btnDangNhap(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: txtUsername.text!, password: txtPassword.text!) { (result, err) in
            if err != nil {
                print("Error : \(String(describing: err))")
            }
            else{
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar") as? HomeTabBarController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    var check = false;
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.view.backgroundColor = UIColor(patternImage: ( #imageLiteral(resourceName: "background") ))
        buttonLogin.layer.cornerRadius = 25.0
        buttonRegister.layer.cornerRadius = 25.0
    }
}






