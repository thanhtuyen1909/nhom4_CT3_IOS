//
//  ViewController.swift
//  Project
//
//  Created by Chun on 6/16/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //let transition = SlideInTransition()
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var sideBar: UITableView!
    var isSideMenuOpen:Bool = false
    
    var arrData = ["Đặt hàng", "Giỏ hàng", "Kho hàng", "Lịch sử đơn hàng", "Đăng xuất"];
    var arrImg = [#imageLiteral(resourceName: "Order"), #imageLiteral(resourceName: "Cart"), #imageLiteral(resourceName: "Square"), #imageLiteral(resourceName: "History"), #imageLiteral(resourceName: "Logout")];
    
    
    // MARK: func xu ly
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MenuTableViewCell
        cell.imgMenu.image = arrImg[indexPath.row]
        cell.titleMenu.text = arrData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          print("Vị trí \(indexPath.row)")
        switch indexPath.row {
        case 0:
            let height = self.view.frame.size.height
            let width = self.view.frame.size.width * 0.8
            sideBar.isHidden = true
            sideView.isHidden = true
            isSideMenuOpen = false
            sideView.frame = CGRect(x: 0, y: 88, width: width, height: height)
            sideBar.frame = CGRect(x: 0, y: 0, width: width, height: height)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            sideView.frame = CGRect(x: 0, y: 88, width: 0, height: height)
            sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: height)
            UIView.commitAnimations()        case 1:
            let listCart:ListCartController = self.storyboard?.instantiateViewController(withIdentifier: "ListCartController") as! ListCartController
            self.navigationController?.pushViewController(listCart, animated: true)
        case 2:
            let wareHouse:WareHouseController = self.storyboard?.instantiateViewController(withIdentifier: "WareHouseController") as! WareHouseController
            self.navigationController?.pushViewController(wareHouse, animated: true)
        case 3:
            let invoices:InvoicesController = self.storyboard?.instantiateViewController(withIdentifier: "InvoicesController") as! InvoicesController
            self.navigationController?.pushViewController(invoices, animated: true)
        case 4:
//            let listCart:ListCartController = self.storyboard?.instantiateViewController(withIdentifier: "ListCartController") as! ListCartController
//            self.navigationController?.pushViewController(listCart, animated: true)
            print("Logout")
        default:
            print("Vị trí \(indexPath.row)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBar.dataSource = self
        sideBar.delegate = self
        sideView.isHidden = true
        isSideMenuOpen = false
    }
    
    
    @IBAction func btnMenu(_ sender: UIBarButtonItem) {
        let height = self.view.frame.size.height
        let width = self.view.frame.size.width * 0.8
        sideBar.isHidden = false
        sideView.isHidden = false
        self.view.bringSubviewToFront(sideView)
        if !isSideMenuOpen {
            isSideMenuOpen = true
            sideView.frame = CGRect(x: 0, y: 88, width: 0, height: height)
            sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: height)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            sideView.frame = CGRect(x: 0, y: 88, width: width, height: height)
            sideBar.frame = CGRect(x: 0, y: 0, width: width, height: height)
            UIView.commitAnimations()
        } else {
            sideBar.isHidden = true
            sideView.isHidden = true
            isSideMenuOpen = false
            sideView.frame = CGRect(x: 0, y: 88, width: width, height: height)
            sideBar.frame = CGRect(x: 0, y: 0, width: width, height: height)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            sideView.frame = CGRect(x: 0, y: 88, width: 0, height: height)
            sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: height)
            UIView.commitAnimations()
        }
    }
}
