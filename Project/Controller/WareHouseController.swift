//
//  WareHouseController.swift
//  Project
//
//  Created by Chun on 6/16/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
import Firebase

class WareHouseController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: - properties
    var productLists = [Product] ()
    var product:Product = Product ()
    
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var seachProduct: UISearchBar!
    
    // MARK: - functions
    // Chuan bi so dong
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productLists.count
    }
    
    // Tim kiem san pham
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var productLists1 = [Product] ();
        
        if searchText == "" {
            getData()
        }
        else {
            for product in self.productLists {
                if product.productName.contains(searchText) {
                    productLists1.append(product);
                }
            }
            self.productLists = productLists1;
        }
        self.productTable.reloadData();
    }
    
    // Chuan bi du lieu them vao Firebase
    @IBAction func btnAddProduct(_ sender: Any) {
        let alert = UIAlertController(title:
            "Thêm sản phẩm", message: "Thêm sản phẩm mới", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            let name = alert.textFields?[0].text
            let amount:Int? = Int(alert.textFields?[1].text ?? "")
            let price:Int? = Int(alert.textFields?[2].text ?? "")
            self.addProduct(name: name!, amount: amount!, price: price!)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { edtProductName in
            edtProductName.placeholder = "Nhập tên sản phẩm"
        }
        alert.addTextField { edtProductAmount in
            edtProductAmount.placeholder = "Nhập số lượng"
        }
        alert.addTextField { edtProductPrice in
            edtProductPrice.placeholder = "Nhập giá"
        }
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Do du lieu vao tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell:WareHouseCell = tableView.dequeueReusableCell(withIdentifier: "WareCell") as? WareHouseCell {
            cell.productName.text = self.productLists[indexPath.row].productName
            cell.productAmount.text = "\(self.productLists[indexPath.row].productAmount)"
            cell.productPrice.text = "\(self.productLists[indexPath.row].productPrice) VND"
            return cell
        } else {
            fatalError("Cannot create cell!");
        }
    }
    
    // Chuan bi so luong section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Ham action swipe ben Trai: Delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    // Ham action goi su kien xoa
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let product = productLists[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.deleteProduct(name: product.productName)
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "delete")
        action.backgroundColor = .red
        return action
    }
    
    // Ham action swipe ben Phai: Edit
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = editAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    // Ham action goi su kien sua
    func editAction(at indexPath: IndexPath) -> UIContextualAction {
        let product = productLists[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            let alert = UIAlertController(title: product.productName, message: "Cập nhật sản phẩm", preferredStyle: .alert)
            let updateAct = UIAlertAction(title: "Update", style: .default) { (_) in
                let name = alert.textFields?[0].text
                let amount:Int? = Int(alert.textFields?[1].text ?? "")
                let price:Int? = Int(alert.textFields?[2].text ?? "")
                self.updateProduct(name: name!, amount: amount!, price: price!)
            }
            let cancelAct = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addTextField { edtProductName in
                edtProductName.text = product.productName
            }
            alert.addTextField { edtProductAmount in
                edtProductAmount.text = "\(product.productAmount)"
            }
            alert.addTextField { edtProductPrice in
                edtProductPrice.text = "\(product.productPrice)"
            }
            alert.addAction(updateAct)
            alert.addAction(cancelAct)
            self.present(alert, animated: true, completion: nil)
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "edit")
        action.backgroundColor = .green
        return action
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTable.delegate = self
        self.productTable.dataSource = self
        self.seachProduct.delegate = self
        getData()
    }
    
    // Lay du lieu tu Firebase
    func getData(){
        let ref = Database.database().reference().child("Ingredients")
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount >= 0{
                self.productLists.removeAll()
                for pro in snapshot.children.allObjects as! [DataSnapshot]{
                    let productData = pro.value as? NSDictionary
                    let productName = productData!["name"] as? String ?? ""
                    let productPrice:Int = productData!["price"] as? Int ?? 0
                    let productAmount:Int = productData!["quantity"] as? Int ?? 0
                    
                    self.product = Product(productName: productName, productAmount: productAmount, productPrice: productPrice)!
                    self.productLists.append(self.product);
                }
                
                self.productTable.reloadData()
            }
        })
    }
    
    // MARK: delete, add and update product
    func deleteProduct(name: String){
        var idProduct: String?
        let ref = Database.database().reference().child("Ingredients")
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount >= 0{
                for pro in snapshot.children.allObjects as! [DataSnapshot]{
                    let productData = pro.value as? NSDictionary
                    if let productName = productData!["name"] as? String, productName == name {
                        idProduct = pro.key;
                        ref.child(idProduct!).removeValue();
                    }
                }
            }
        })
        self.productTable.reloadData()
    }
    
    func updateProduct(name: String, amount: Int, price: Int){
        var idProduct: String?
        let ref = Database.database().reference().child("Ingredients")
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount >= 0{
                for pro in snapshot.children.allObjects as! [DataSnapshot]{
                    let productData = pro.value as? NSDictionary
                    if let productName = productData!["name"] as? String, productName == name {
                        idProduct = pro.key;
                        ref.child(idProduct!).setValue(["name": name, "price": price, "quantity": amount]);
                    }
                }
            }
        })
        self.productTable.reloadData()
    }
    
    func addProduct(name: String, amount: Int, price: Int) {
        let ref = Database.database().reference().child("Ingredients")
        ref.childByAutoId().setValue(["name": name, "price": price, "quantity": amount]);
        self.productTable.reloadData()
    }
}

