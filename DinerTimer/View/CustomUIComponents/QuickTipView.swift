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
        
        private var bodyLabel: UILabel = {
            let label = UILabel()
            label.text = "BODY TEXT HERE"
            label.textAlignment = .center
            label.textColor = #colorLiteral(red: 0.1545568705, green: 0.117007874, blue: 0.04884755611, alpha: 1)
            label.font = UIFont(name: "SFProText-Regular", size: 12)
            label.setHeight(height: 30)
            return label
        }()
        
        //MARK: - Lifecycle
        override init(frame: CGRect) {
            super.init(frame: .zero)
            
            configureUI()
        
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        //MARK: - Helpers
        
        private func configureUI() {
            
            self.backgroundColor = #colorLiteral(red: 0.9940704703, green: 0.9595301747, blue: 0.968749702, alpha: 1)
            self.layer.borderWidth = 2
            self.layer.borderColor = #colorLiteral(red: 0.9283291101, green: 0.6998675466, blue: 0.7616847754, alpha: 1)
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
            bodyLabel.anchor(top: titleLabel.bottomAnchor)
            bodyLabel.centerX(inView: self)
        }
        
    
}
