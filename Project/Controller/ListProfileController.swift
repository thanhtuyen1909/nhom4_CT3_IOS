//
//  ListProfileController.swift
//  Project
//
//  Created by Chun on 6/19/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit

class ListProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - properties
    @IBOutlet weak var profileTable: UITableView!
    
    
    var arrData = ["Đổi mật khẩu", "Đăng xuất", "Doanh thu "];
    var arrImg = [#imageLiteral(resourceName: "pass"), #imageLiteral(resourceName: "Logout"), #imageLiteral(resourceName: "Charts"), #imageLiteral(resourceName: "next")];
    
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
        switch arrData[indexPath.row] {
        // Doi mat khau
        case arrData[0]:
            let resetPass:ResetPassController = self.storyboard?.instantiateViewController(withIdentifier: "resetPass") as! ResetPassController
            self.navigationController?.pushViewController(resetPass, animated: true)
            print("Doi mat khau");
        // Dang xuat
        case arrData[1]:
            //                        let login:LoginController = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginController
            //                        self.navigationController?.pushViewController(warlogineHouse, animated: true)
            print("Dang xuat");
        case arrData[2]:
            print("Doanh thu")
        default:
            print("Vị trí \(indexPath.row)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTable.dataSource = self
        profileTable.delegate = self
    }
    
}
