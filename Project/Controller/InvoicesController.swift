//
//  InvoicesController.swift
//  Project
//
//  Created by Chun on 6/16/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit

class InvoicesController: UIViewController {
    //let transition = SlideInTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
//        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "ListController") as? ListController else { return }
//        menuViewController.didTapMenuType = { menuType in self.transitionToAnotherScreen(menuType)}
//        menuViewController.modalPresentationStyle = .overCurrentContext
//        menuViewController.transitioningDelegate = self
//        present(menuViewController, animated: true)
//    }
//
//    func transitionToAnotherScreen(_ menuType:MenuType) {
//
//        switch menuType {
//        case .khohang:
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc  = storyboard.instantiateViewController(withIdentifier: "WareHouseController")
//            self.navigationController?.show(vc, sender: nil)
//
//        case .dathang:
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "ListCartController")
//            self.navigationController?.show(vc, sender: nil)
//
//        case .lichsudonhang:
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "InvoicesController")
//            self.navigationController?.show(vc, sender: nil)
//
//        case .dangxuat:
//            //            guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "WareHouseController") as? WareHouseController else { return }
//            //            menuViewController.modalPresentationStyle = .overCurrentContext
//            //            menuViewController.transitioningDelegate = self
//            //            present(menuViewController, animated: true)
//            print("Logout")
//        default:
//            print("Khong the chuyen man hinh!!")
//        }
//    }
}

//extension InvoicesController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.isPresenting = true
//        return transition
//    }
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.isPresenting = false
//        return transition
//    }
//}
