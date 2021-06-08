//
//  FoodStallsViewController.swift
//  Project
//
//  Created by danh on 6/6/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
class FoodStallsViewController: UIViewController  {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var ref = DatabaseReference.init()
    var store = StorageReference.init()
    var coffee:Coffee = Coffee()
    var test:[String] = ["a","b"]
    //create datasource
    var coffeelList:[Coffee] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.store = Storage.storage().reference()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        print(self.test.count)
        // Do any additional setup after loading the view.
    }
    //get datasoure
    func getData(){
        self.ref.child("Products").getData { (err, snapshot) in
            if err != nil{
                print("Error : \(String(describing: err))")
            }else if snapshot.exists(){
                let dict = snapshot.value as! NSDictionary
                for i in 1...dict.count{
                    let temp_dict = dict["Product\(i)"] as? NSDictionary
                    let coffeeName = temp_dict!["name"] as? String ?? ""
                    let imageName =  temp_dict!["img"] as? String ?? ""
                    let coffeePrice:Int
                    coffeePrice = temp_dict!["price"] as? Int ?? 0
                    let islandRef = self.store.child("images/\(imageName)")
                    var coffeeImage = UIImage(data: Data())
                    
                    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                    islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            print("get error : \(error)")
                        } else {
                            // Data for "images/island.jpg" is returned
                            coffeeImage = UIImage(data: data!)!
                            print("get data successfully")
                            self.coffee = Coffee(coffeeName: coffeeName, coffeeImage: coffeeImage!, coffeePrice: coffeePrice)
                            
                        }
                    }
                    self.coffeelList += [self.coffee]
                    self.test += ["c"]
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FoodStallsViewController :  UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeelList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CoffeeTableViewCell
        cell?.mealImage.image = coffeelList[indexPath.row].coffeeImage
        cell?.mealName.text = coffeelList[indexPath.row].coffeeName
        cell?.mealPrice.text = "\(coffeelList[indexPath.row].coffeePrice) đ"
        print("get cell")
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
