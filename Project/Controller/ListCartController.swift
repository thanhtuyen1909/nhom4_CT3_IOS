//
//  ListCartController.swift
//  Project
//
//  Created by Chun on 6/16/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class ListCartController: UIViewController, UITableViewDataSource , UITableViewDelegate {
    var listCart = [Coffee]()
    var listQuantity = [Int]()
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var tableCart: UITableView!
    
    func formatPrice(priceFrom:Int)->String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.groupingSeparator = ","
        currencyFormatter.groupingSize = 3
        currencyFormatter.usesGroupingSeparator = true
        
        return currencyFormatter.string(from: priceFrom as NSNumber)!;
    }
    
    @objc func pressSub(_ sender: UIButton) {
        let index = sender.tag
        var idProduct: String?
        self.listQuantity[index] -= 1
        let ref = Database.database().reference().child("Carts")
        if self.listQuantity[index] == 0 {
            ref.getData { (error, snapshot) in
                if snapshot.childrenCount >= 0 {
                    for cart in snapshot.children.allObjects as! [DataSnapshot]{
                        let cartData = cart.value as? NSDictionary
                        if let coffeeName = cartData!["name"] as? String, coffeeName == self.listCart[index].coffeeName {
                            idProduct = cart.key;
                            ref.child(idProduct!).removeValue()
                        }
                    }
                }
            }
        }else{
            ref.getData { (error, snapshot) in
                if snapshot.childrenCount >= 0 {
                    for cart in snapshot.children.allObjects as! [DataSnapshot]{
                        let cartData = cart.value as? NSDictionary
                        let coffeeName = cartData!["name"] as? String ?? ""
                        if coffeeName == self.listCart[index].coffeeName {
                            let coffeePrice = cartData!["price"] as? Int ?? 0
                            let coffeeImg = cartData!["image"] as? String ?? ""
                            let uid = Auth.auth().currentUser!.uid
                            let quantityRe:Int = self.listQuantity[index] + 1
                            let price:Int = coffeePrice - (coffeePrice / quantityRe);
                            ref.child(cart.key).setValue(["name":coffeeName, "image":coffeeImg, "price":price, "quantity":self.listQuantity[index], "uid":uid])
                        }
                    }
                }
            }
        }
    }
    
    @objc func pressAdd(_ sender: UIButton) {
        let index = sender.tag
        self.listQuantity[index] += 1
        let ref = Database.database().reference().child("Carts")
        
        ref.getData { (error, snapshot) in
            if snapshot.childrenCount >= 0 {
                for cart in snapshot.children.allObjects as! [DataSnapshot]{
                    let cartData = cart.value as? NSDictionary
                    let coffeeName = cartData!["name"] as? String ?? ""
                    if coffeeName == self.listCart[index].coffeeName {
                        var dict = [String:Any]()
                        let coffeePrice = cartData!["price"] as? Int ?? 0
                        let coffeeImg = cartData!["image"] as? String ?? ""
                        let uid = Auth.auth().currentUser!.uid
                        let quantityRe:Int = self.listQuantity[index] - 1
                        let price:Int =  (coffeePrice / quantityRe) * self.listQuantity[index];
                        dict = ["name":coffeeName, "image":coffeeImg, "price": price, "quantity":self.listQuantity[index], "uid":uid]
                        ref.child(cart.key).setValue(dict)
                    }
                }
            }
        }
    }
    
    // MARK: func xu ly
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listCart.count
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell:CartTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "CartCell") as? CartTableViewCell {
            cell.btnSub.tag = indexPath.row
            cell.btnAdd.tag = indexPath.row
            let coffeePr = self.listCart[indexPath.row]
            let storageRef = Storage.storage().reference();
            let imageRef = storageRef.child("images/\(coffeePr.coffeeImage)");
            imageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if error == nil {
                    if let temp = UIImage(data: data!) {
                        cell.cartImage.image = temp;
                    }
                } else {
                    print("An error occurred! \(String(describing: error))");
                }
            }
            cell.cartName.text = coffeePr.coffeeName
            cell.cartPrice.text = "\(formatPrice(priceFrom: coffeePr.coffeePrice)) VND"
            cell.cartQuantity.text = "\(self.listQuantity[indexPath.row])"
            
            return cell
        } else {
            fatalError("Can't create cell!")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableCart.dataSource = self
        self.tableCart.delegate = self
        getData()
    }
    
    func getData(){
        var quantity = 0
        var tempCoffee:Coffee = Coffee()
        var totalPrice:Int = 0
        let ref = Database.database().reference().child("Carts")
        
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount >= 0{
                self.listCart.removeAll()
                self.listQuantity.removeAll()
                for cart in snapshot.children.allObjects as! [DataSnapshot]{
                    let cartData = cart.value as? NSDictionary
                    let uid = cartData!["uid"] as? String ?? ""
                    if uid == Auth.auth().currentUser!.uid {
                        let coffeeName = cartData!["name"] as? String ?? ""
                        let coffeePrice = cartData!["price"] as? Int ?? 0
                        let coffeeImg = cartData!["image"] as? String ?? ""
                        quantity = cartData!["quantity"] as? Int ?? 0
                        tempCoffee = Coffee(coffeeName: coffeeName, coffeeImage: coffeeImg, coffeePrice: coffeePrice)!
                        totalPrice += coffeePrice
                        self.listCart.append(tempCoffee)
                        self.listQuantity.append(quantity)
                    }
                }
                self.tableCart.reloadData()
                self.totalPrice.text = "\(self.formatPrice(priceFrom: totalPrice)) VND"
            }
        })
    }
}
