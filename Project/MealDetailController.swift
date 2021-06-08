//
//  ViewController.swift
//  Food Manage
//
//  Created by CNTT on 4/13/21.
//  Copyright © 2021 fit.tdc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class MealDetailController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    // MARK: Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var edtMealName: UITextField!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var ratingControl: RatingControl!

    var flag = 0;
    //    Dtuong uy quyen: textview
    //    Uy quyen
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegation
        edtMealName.delegate = self;
        
        
        //
        
    }
    // MAEK: TextField Delegate functions
    //    tab vao Done thi goi ham nay
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //       an bam phim
        textField.resignFirstResponder()
        return true
    }
    // lay du lieu ra sau khi soan noi dung
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let newName = textField.text{
            //print("Food name is: \(newName)")
            navigationItem.title = newName;
        }
    }
    //    MARK: Image processing
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let store = Storage.storage().reference(withPath: "images/camep.jpg")
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = selectedImage
            guard let data = selectedImage.jpegData(compressionQuality: 0.75) else{return }
            
            let uploadMetadata = StorageMetadata.init()
            uploadMetadata.contentType = "image/jpeg"
            dismiss(animated: true, completion: nil)
            _ = store.putData(data, metadata: uploadMetadata) { (downloadMetadata, err) in
                if err != nil{
                    print("Got some error")
                    return
                    
                }
                print("put data success")
            }
        }
    }
    
    
    
    //    moi lan tap len img an ban phim
    @IBAction func imageProcessing(_ sender: UITapGestureRecognizer) {
        edtMealName.resignFirstResponder()
        //       chuyen den thu vien anh
        //        1. tao doi tuong
        let imagePicker = UIImagePickerController()
        //        2. noi chua anh: config datasource(image) for the image pincker
        imagePicker.sourceType = .photoLibrary
        //      uy quyen
        imagePicker.delegate = self
        
        //hien man hinh de chon anh: show the image picker
        present(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if(flag == 0){
            dismiss(animated: false, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    //MARK: cancel action bar item
}

