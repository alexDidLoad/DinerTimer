//
//  DescriptionButtons.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/15/20.
//

import UIKit

class DescriptionButton: UIButton {
    
    //MARK: - Properties
    
    private let itemName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Medium", size: 18)
        label.text = "Name"
        label.textAlignment = .center
        label.textColor = .black
        label.setHeight(height: 21)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.text = "Description"
        label.textAlignment = .center
        label.textColor = .black
        label.setHeight(height: 16)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = PaddingLabel()
        label.font = UIFont(name: "SFProText-Medium", size: 13)
        label.text = "Time"
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.9466593862, green: 0.7775826454, blue: 0.4798718095, alpha: 1)
        label.setHeight(height: 24)
        label.padding(4, 4, 8, 8)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    
    //MARK: - Lifecycle
    
    init(name: String?, description: String?, estimatedTime: String?) {
        super.init(frame: .zero)
        
        configureUI(name: name, description: description, estimatedTime: estimatedTime)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI(name: String?, description: String?, estimatedTime: String?) {
        
        self.backgroundColor = #colorLiteral(red: 0.9894167781, green: 0.9567651153, blue: 0.8911890388, alpha: 1)
        self.setDimensions(height: 76, width: 345)
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.9427288771, green: 0.77365309, blue: 0.475846231, alpha: 1)
        
        self.layer.shadowColor = #colorLiteral(red: 0.9466593862, green: 0.7775826454, blue: 0.4798718095, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.bounds = self.bounds
        self.layer.position = self.center
        
        itemName.text = name ?? "Name"
        addSubview(itemName)
        itemName.anchor(top: self.topAnchor,
                        leading: self.leadingAnchor,
                        paddingTop: 16,
                        paddingLeading: 16)
        
        descriptionLabel.text = description ?? "Description"
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: itemName.bottomAnchor,
                                leading: self.leadingAnchor,
                                paddingTop: 7,
                                paddingLeading: 16)
        
        timeLabel.text = estimatedTime ?? "Time"
        addSubview(timeLabel)
        timeLabel.anchor(top: self.topAnchor,
                         trailing: self.trailingAnchor,
                         paddingTop: 16,
                         paddingTrailing: 16)
    }
    
}
