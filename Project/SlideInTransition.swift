//
//  SlideInTransition.swift
//  Project
//
//  Created by Chun on 6/16/21.
//  Copyright © 2021 nhom4. All rights reserved.
//

import UIKit
//
//class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
//    
//    // MARK - properties
//    var isPresenting = false
//    let dimmingView = UIView()
//    
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.3
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let toMenuController = transitionContext.viewController(forKey: .to),
//            let fromMenuController = transitionContext.viewController(forKey: .from) else { return }
//        let containerView = transitionContext.containerView
//        let finalWitdh = toMenuController.view.bounds.width * 0.8
//        let finalHeight = toMenuController.view.bounds.height
//        
//        if isPresenting {
//            // Them dimming view
//            dimmingView.backgroundColor = .black
//            dimmingView.alpha = 0.0
//            containerView.addSubview(dimmingView)
//            dimmingView.frame = containerView.bounds
//            
//            // Them menu slide bar vao container
//            containerView.addSubview(toMenuController.view)
//            
//            // Tao frame off man hinh
//            toMenuController.view.frame = CGRect(x: -finalWitdh, y: 0, width: finalWitdh, height: finalHeight)
//        }
//        
//        // Animate tren man hinh
//        let transform = {
//            self.dimmingView.alpha = 0.5
//            toMenuController.view.transform = CGAffineTransform(translationX: finalWitdh, y: 0)
//        }
//        
//        // Animate tro ve man hinh
//        let identity = {
//            self.dimmingView.alpha = 0.0
//            fromMenuController.view.transform = .identity
//        }
//        
//        // Animate chuyen doi
//        let duration = transitionDuration(using: transitionContext)
//        let isCancelled = transitionContext.transitionWasCancelled
//        UIView.animate(withDuration: duration, animations: {
//            self.isPresenting ? transform() : identity()
//        }) { (_) in
//            transitionContext.completeTransition(!isCancelled)
//        }
//    }
//}
