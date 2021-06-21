//
//  RegisterController.swift
//  Project
//
//  Created by Chun on 6/20/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class RegisterController: UIViewController {

    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtComfirmPass: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func btnLoginTap(_ sender: Any) {
        if let registerView = self.storyboard?.instantiateViewController(withIdentifier: "Login") as? LoginController{
            self.view.window?.rootViewController = registerView
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func btnRegisterTap(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passComfirm = txtComfirmPass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if(password == passComfirm) {
                // Create the user
                Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                    
                    // Check for errors
                    if err != nil {
                        
                        // There was an error creating the user
                        self.showError("Lỗi tạo tài khoản!")
                    }
                    else {
                        
                        // User was created successfully, now store info in tble Users
                        if Auth.auth().currentUser!.uid != ""{
                            let ref = Database.database().reference()
                            ref.child("Users").childByAutoId().setValue(["uid": Auth.auth().currentUser!.uid, "role": "user"])
                            // Transition to the home screen
                            self.transitionToHome()
                        }
                        else {
                            self.showError("Chưa đăng nhập!")
                        }
                    }
                }
            } else {
                self.showError("Không trùng khớp mật khẩu!")
            }
        }
    }
    
    var check = false;
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: ( #imageLiteral(resourceName: "background") ))
        buttonLogin.layer.cornerRadius = 25.0
        buttonRegister.layer.cornerRadius = 25.0
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(txtEmail)
        Utilities.styleTextField(txtPass)
        Utilities.styleTextField(txtComfirmPass)
        Utilities.styleFilledButton(buttonRegister)
        Utilities.styleFilledButton(buttonLogin)
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        if(txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtPass.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtComfirmPass.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Vui lòng nhập đủ các trường!"
        }
        let cleanedPassword = txtPass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Vui lòng đảm bảo mật khẩu của bạn có ít nhất 8 ký tự, chứa một ký tự đặc biệt và một số."
        }
        return nil
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeView = storyboard?.instantiateViewController(withIdentifier: "Tabbar") as? HomeTabBarController
        
        view.window?.rootViewController = homeView
        view.window?.makeKeyAndVisible()
    }

}
