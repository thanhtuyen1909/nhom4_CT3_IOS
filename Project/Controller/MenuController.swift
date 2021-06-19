//
//  ViewController.swift
//  Project
//
//  Created by Chun on 6/16/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class MenuController: UIViewController, UITableViewDataSource , UITableViewDelegate, UISearchBarDelegate {
    //create datasource
    var coffeeList = [Coffee] ()
    var coffee:Coffee = Coffee()
    
    //let transition = SlideInTransition()
    @IBOutlet weak var tableMeal: UITableView! {
        didSet {
            self.tableMeal.dataSource = self
        }
    }
    @IBOutlet weak var searchCoffee: UISearchBar!
    
    
    // MARK: - functions
    @IBAction func addCoffee(_ sender: Any) {
        if let coffeeDetail:CoffeeDetailController = self.storyboard?.instantiateViewController(withIdentifier: "coffeeDetail") as? CoffeeDetailController {
            self.navigationController?.pushViewController(coffeeDetail, animated: true)
        }
    }
    
    // Tim kiem coffee
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var coffeeList1 = [Coffee] ();
        
        if searchText == "" {
            getData()
        }
        else {
            for coffee in self.coffeeList {
                if coffee.coffeeName.contains(searchText) {
                    coffeeList1.append(coffee);
                }
            }
            self.coffeeList = coffeeList1;
        }
        self.tableMeal.reloadData();
    }
    
    // Ham action swipe ben Phai: Edit
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = editAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    // Ham action chuyen sang trang detail: Edit
    func editAction(at indexPath: IndexPath) -> UIContextualAction {
        let coffee = coffeeList[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            if let coffeeDetail:CoffeeDetailController = self.storyboard?.instantiateViewController(withIdentifier: "coffeeDetail") as? CoffeeDetailController {
                coffeeDetail.coffee.coffeeImage = coffee.coffeeImage
                coffeeDetail.coffee.coffeeName = coffee.coffeeName
                coffeeDetail.coffee.coffeePrice = coffee.coffeePrice
                coffeeDetail.checkAddCoffee = false
                self.navigationController?.pushViewController(coffeeDetail, animated: true)
            }
            
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "edit")
        action.backgroundColor = .green
        return action
    }
    
    // Ham action swipe ben Trai: Delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    // Ham action goi su kien xoa
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let coffee = coffeeList[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            var idCoffee: String?
            let ref = Database.database().reference().child("Products")
            ref.observe(DataEventType.value, with: {(snapshot) in
                if snapshot.childrenCount >= 0{
                    for cof in snapshot.children.allObjects as! [DataSnapshot]{
                        let coffeeData = cof.value as? NSDictionary
                        if let cofName = coffeeData!["name"] as? String, cofName == coffee.coffeeName {
                            idCoffee = cof.key;
                            ref.child(idCoffee!).removeValue();
                        }
                    }
                }
            })
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "delete")
        action.backgroundColor = .red
        return action
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableMeal.delegate = self
        self.tableMeal.dataSource = self
        self.searchCoffee.delegate = self
        getData()
    }
    
    // Lay du lieu tu Firebase
    func getData () {
        let ref = Database.database().reference().child("Products")
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount >= 0{
                self.coffeeList.removeAll()
                for cfee in snapshot.children.allObjects as! [DataSnapshot]{
                    let coffeeData = cfee.value as? NSDictionary
                    let coffeeName = coffeeData!["name"] as? String ?? ""
                    let imageName =  coffeeData!["img"] as? String ?? ""
                    let coffeePrice:Int = coffeeData!["price"] as? Int ?? 0
                    
                    self.coffee = Coffee(coffeeName: coffeeName, coffeeImage: imageName, coffeePrice: coffeePrice)!
                    self.coffeeList.append(self.coffee);
                }
                
                self.tableMeal.reloadData()
            }
        })
    }
    
    // Chuan bi so dong
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coffeeList.count
    }
    
    
    // Do du lieu tung dong
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let store = Storage.storage().reference(forURL: "gs://greencoffee-5ad6f.appspot.com")
        if let cell:CoffeeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CoffeCell") as? CoffeeTableViewCell {
            
            let coffeePr = self.coffeeList[indexPath.row];
            
            // Get image from Online Database:
            let storageRef = Storage.storage().reference();
            let imageRef = storageRef.child("images/\(coffeePr.coffeeImage)");
            imageRef.getData(maxSize: 30 * 1024 * 1024) { (data, error) in
                if error == nil {
                    if let temp = UIImage(data: data!) {
                        cell.mealImage.image = temp;
                    }
                } else {
                    print("An error occurred! \(String(describing: error))");
                }
            }
            cell.mealName.text = coffeePr.coffeeName
            cell.mealPrice.text = "\(coffeePr.coffeePrice) VND"
            return cell;
        }
        else {
            fatalError("Cannot create cell!");
        }
    }
    
    // Chuan bi so luong section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
