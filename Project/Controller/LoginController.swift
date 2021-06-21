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
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func btnDangNhap(_ sender: UIButton) {
        // Create cleaned versions of the text field
        let email = txtUsername.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if err != nil {
                // Couldn't sign in
                self.showError("Vui lòng kiểm tra lại thông tin")
            }
            else{
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar") as? HomeTabBarController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func btnDangKy(_ sender: UIButton) {
        if let registerView = self.storyboard?.instantiateViewController(withIdentifier: "Register") as? RegisterController{
            self.view.window?.rootViewController = registerView
            self.view.window?.makeKeyAndVisible()
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
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(txtUsername)
        Utilities.styleTextField(txtPassword)
        Utilities.styleFilledButton(buttonLogin)
        Utilities.styleFilledButton(buttonRegister)
        
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}






