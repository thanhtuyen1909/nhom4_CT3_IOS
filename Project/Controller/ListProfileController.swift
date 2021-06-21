//
//  ListProfileController.swift
//  Project
//
//  Created by Chun on 6/19/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ListProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - properties
    @IBOutlet weak var profileTable: UITableView!
    @IBOutlet weak var email: UILabel!
    
    var arrData = ["Đổi mật khẩu", "Đăng xuất", "Doanh thu", "Quản lý tài khoản"];
    var arrImg = [#imageLiteral(resourceName: "pass"), #imageLiteral(resourceName: "Logout"), #imageLiteral(resourceName: "Charts"), #imageLiteral(resourceName: "users"), #imageLiteral(resourceName: "next")];
    @IBOutlet weak var roleLabel: UILabel!
    
    // MARK: func xu ly
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProfileCell  = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
        cell.profileFuncImg.image = arrImg[indexPath.row]
        cell.profileFuncTitle.text = arrData[indexPath.row]
        cell.profileNextFunc.image = arrImg[arrImg.count - 1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProfileCell
        
        
        switch cell.profileFuncTitle.text {
        // Doi mat khau
        case "Đổi mật khẩu":
            let resetPass:ResetPassController = self.storyboard?.instantiateViewController(withIdentifier: "resetPass") as! ResetPassController
            self.navigationController?.pushViewController(resetPass, animated: true)
        // Dang xuat
        case "Đăng xuất":
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                let login:LoginController = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginController
                self.view.window?.rootViewController = login
                self.view.window?.makeKeyAndVisible()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        case "Doanh thu":
            print("Doanh thu")
        default:
            print("Vị trí \(indexPath.row)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTable.dataSource = self
        profileTable.delegate = self
        self.email.text = Auth.auth().currentUser!.email!
        self.roleLabel.text = getRole()
    }
    
    func getRole() -> String {
        var role: String = ""
        let ref = Database.database().reference().child("Users")
        ref.getData{(error, snapshot) in
            if snapshot.childrenCount >= 0 {
                for user in snapshot.children.allObjects as! [DataSnapshot]{
                    let userData = user.value as? NSDictionary
                    let userID = userData!["uid"] as? String ?? ""
                    let userRole = userData!["role"] as? String ?? ""
                    
                    if userID == Auth.auth().currentUser!.uid {
                        role = userRole
                    }
                }
            }
        }
        return role;
    }
}
