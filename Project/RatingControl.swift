//
//  RatingControl.swift
//  FoodManage
//
//  Created by danh on 4/27/21.
//  Copyright © 2021 danh. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    
    
    private var ratingButton = [UIButton]()
    @IBInspectable var starNumber:Int = 5 {
        didSet{
            ratingButtonSetting()
        }
    };
    @IBInspectable var starSize:CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            ratingButtonSetting()
        }
    };
    @IBInspectable var rateValue:Int = 2{
        didSet{
            updateRateState()
        }
    }
    //constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        ratingButtonSetting()
        
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        ratingButtonSetting()
        
    }
   
    //intialization of RatingControl
    private func ratingButtonSetting(){
        let bundle = Bundle(for: type(of: self))
        let normal = UIImage(named: "normal", in: bundle,compatibleWith: .none)
        let pressed = UIImage(named: "pressed",in: bundle,compatibleWith: .none)
        let selected = UIImage(named: "selected",in: bundle,compatibleWith: .none)
        //clear old button
        for button in ratingButton{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButton.removeAll()
        //create rating button
        for _ in 0..<starNumber{
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive=true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive=true
        button.setImage(normal, for: .normal)
        button.setImage(pressed, for: .highlighted)
        button.setImage(selected, for: .selected)
        button.setImage(selected, for: [.selected,.highlighted	])
        //set event catching for the button
        button.addTarget(self, action: #selector(ratingButtonPress(button:)), for: .touchUpInside)
        //add button to stackview
        addArrangedSubview(button)
        ratingButton += [button]
        
        }
        updateRateState()
    }
    @objc private func ratingButtonPress(button : UIButton){
       
        if let index = ratingButton.firstIndex(of: button){
            if rateValue == index + 1{
                rateValue -= 1
            }
            else{
                rateValue = index + 1
            }
            
        }
        updateRateState()
    }
    private func updateRateState(){
        for button in ratingButton{
            button.isSelected = false;
        }
        for i in 0..<rateValue{
            ratingButton[i].isSelected = true;
        }
        
    }
    
}

