//
//  ResetPassController.swift
//  Project
//
//  Created by Chun on 6/19/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class ResetPassController: UIViewController {
    
    
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtComfirmPass: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func pressSubmit(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            // Create cleaned versions of the data
            let password = txtNewPass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passComfirm = txtComfirmPass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let user = Auth.auth().currentUser
            var credential: AuthCredential
            
            // Prompt the user to re-provide their sign-in credentials
            user?.reauthenticate(with: credential) { error in
                if let error = error {
                    self.showError("Không thể xác minh người dùng!")
                } else {
                    if (password != passComfirm) {
                        self.showError("Mật khẩu và mật khẩu nhập lại là không trùng khớp!")
                    } else {
                        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
                            if error != nil {
                                self.showError("Không thể đổi mật khẩu bây giờ!")
                            } else {
                                self.transitionToHome()
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: ( #imageLiteral(resourceName: "background") ))
        buttonSubmit.layer.cornerRadius = 25.0
        setUpElements()
    }
    
    func validateFields() -> String? {
        if(txtNewPass.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtComfirmPass.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Vui lòng nhập đủ các trường!"
        }
        let cleanedPassword = txtNewPass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Vui lòng đảm bảo mật khẩu của bạn có ít nhất 8 ký tự, chứa một ký tự đặc biệt và một số."
        }
        return nil
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(txtNewPass)
        Utilities.styleTextField(txtComfirmPass)
        Utilities.styleFilledButton(buttonSubmit)
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let profileView = storyboard?.instantiateViewController(withIdentifier: "Tabbar") as? ListProfileController
        
        view.window?.rootViewController = profileView
        view.window?.makeKeyAndVisible()
    }
}
