//
//  QuickTipView.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/15/20.
//

import UIKit

class QuickTipView: UIView {
    
    //MARK: - Properties
    
    private let lightningIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bolt.fill")
        iv.tintColor = #colorLiteral(red: 0.1545568705, green: 0.117007874, blue: 0.04884755611, alpha: 1)
        iv.setDimensions(height: 18, width: 18)
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "QUICK TIP"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1545568705, green: 0.117007874, blue: 0.04884755611, alpha: 1)
        label.font = UIFont(name: "SFProText-Medium", size: 14)
        label.setHeight(height: 30)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "BODY TEXT HERE"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.1545568705, green: 0.117007874, blue: 0.04884755611, alpha: 1)
        label.font = UIFont(name: "SFProText-Medium", size: 12)
        label.setHeight(height: 30)
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        updateTip()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Helpers
    
    private func updateTip() {
        switch breakfastItem.type {
        
        case egg:
            switch breakfastItem.method {
            case pan:
                switch breakfastItem.doneness {
                case sunnyside:
                    bodyLabel.text = "Continue cooking until whites are set"
                default:
                    bodyLabel.text = "Flip as soon as the bottom is set"
                }
            default:
                bodyLabel.text = "Plunge the eggs in ice cold water as soon as it's done"
            }
            
        case bacon:
            switch breakfastItem.method {
            case pan:
                bodyLabel.text = "Cook the bacon starting from a cold pan"
            default:
                bodyLabel.text = "Maintain 1/2 inch of space between each slice"
            }
            
        case pancake:
            switch breakfastItem.method {
            case pan:
                bodyLabel.text = "You can flip the pancake when bubbles begin to appear!"
            default:
                bodyLabel.text = "Rotate the pan halfway to cook evenly"
            }
            
        default:
            switch breakfastItem.method {
            case pan:
                bodyLabel.text = "Add just enough oil to cover the bottom of the pan"
            default:
                bodyLabel.text = "Rotate the pan halfway to cook evenly"
            }
        }
    }
    
    private func configureUI() {
        
        self.backgroundColor = #colorLiteral(red: 0.9940704703, green: 0.9595301747, blue: 0.968749702, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 1, green: 0.7170290299, blue: 0.7009517906, alpha: 1)
        self.setDimensions(height: 65, width: 345)
        layer.cornerRadius = 16
        
        
        
        addSubview(lightningIcon)
        lightningIcon.anchor(top: self.topAnchor,
                             leading: self.leadingAnchor,
                             paddingTop: 10,
                             paddingLeading: 10)
        addSubview(titleLabel)
        titleLabel.anchor(top: self.topAnchor,
                          leading: lightningIcon.trailingAnchor,
                          paddingLeading: 5)
        
        addSubview(bodyLabel)
        bodyLabel.anchor(top: titleLabel.bottomAnchor,
                         leading: leadingAnchor,
                         trailing: trailingAnchor)
        bodyLabel.centerX(inView: self)
    }
    
    
}
