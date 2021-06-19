
//
//  CoffeeDetailController.swift
//  Project
//
//  Created by Chun on 6/19/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class CoffeeDetailController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var coffee:Coffee = Coffee()
    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var coffeeName: UITextField!
    @IBOutlet weak var coffeePrice: UITextField!
    @IBOutlet weak var btnGui: UIButton!
    
    var checkAddCoffee:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!checkAddCoffee) {
            self.coffeeName.text = coffee.coffeeName
            self.coffeePrice.text = String(describing: coffee.coffeePrice)
            // Get image from Online Database:
            let storageRef = Storage.storage().reference();
            let imageRef = storageRef.child("images/\(String(describing: coffee.coffeeImage))");
            imageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if error == nil {
                    if let temp = UIImage(data: data!) {
                        self.coffeeImage.image = temp;
                    }
                } else {
                    print("An error occurred! \(String(describing: error))");
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.coffeeImage.image = selectedImage
            // an di thu vien anh
            dismiss(animated: true, completion: nil)
        }
        
        
    }
    func uploadFile(filename:String,data:Data){
        // Create storage reference
        let ref = Storage.storage().reference()
        let photoRef = ref.child("images/\(filename)")
        
        // Create file metadata including the content type
        let metadata = StorageMetadata()
        metadata.contentType = "image/*"
        
        // Upload data and metadata
        photoRef.putData(data, metadata: metadata)
    }
    // Moi lan tap len img an ban phim
    @IBAction func imageProcessing(_ sender: UITapGestureRecognizer) {
        coffeeName.resignFirstResponder()
        // chuyen den thu vien anh
        // 1. tao doi tuong
        let imagePicker = UIImagePickerController()
        // 2. noi chua anh: config datasource(image) for the image pincker
        imagePicker.sourceType = .photoLibrary
        // uy quyen
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        // hien man hinh de chon anh: show the image picker
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func submitCoffee(_ sender: Any) {
        // Chuan bi du lieu
        let name = self.coffeeName.text ?? ""
        let img = "\(name).jpg"
        let price = Int(self.coffeePrice.text!)
        
        // Upload file
        uploadFile(filename: "\(name).jpg", data: (self.coffeeImage.image?.jpegData(compressionQuality: 0.75))!)
        
        // Upload product
        let ref = Database.database().reference().child("Products")
        
        if (!checkAddCoffee) {
            var idCoffee: String?
            ref.observe(DataEventType.value, with: {(snapshot) in
                if snapshot.childrenCount >= 0{
                    for cof in snapshot.children.allObjects as! [DataSnapshot]{
                        let coffeeData = cof.value as? NSDictionary
                        if let cofName = coffeeData!["name"] as? String, cofName == name {
                            idCoffee = cof.key;
                            ref.child(idCoffee!).setValue(["name": name, "price": price!, "img": img]);
                        }
                    }
                }
            })
        } else {
            ref.childByAutoId().setValue(["name": name, "price": price!, "img": img]);
        }
    }
}
