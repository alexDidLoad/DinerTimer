//
//  CustomItemButton.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/11/20.
//

import UIKit

class CustomItemButton: UIButton {
    
    //MARK: - Properties
    
    private let labelView: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.9627792239, green: 0.9252207875, blue: 0.8597199321, alpha: 1)
        label.setHeight(height: 35)
        label.layer.cornerRadius = 7.5
        label.layer.masksToBounds = true
        return label
    }()
    
    private let buttonImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(height: 70, width: 70)
        return iv
    }()
    
    //MARK: - Lifecycle
    
    init(withImage image: UIImage?, text: String?) {
        super.init(frame: .zero)
        if let image = image, let text = text {
            configureUI(image: image, text: text)
        }
    }
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI(image: UIImage? = nil, text: String? = nil) {
        
        buttonImageView.image = image
        labelView.text = text
        
        self.setDimensions(height: 160, width: 160)
        self.layer.cornerRadius = 20
        self.backgroundColor = #colorLiteral(red: 0.9380293489, green: 0.7453880906, blue: 0.4123244882, alpha: 1)
        self.layer.shadowColor = UIColor(red: 0.808, green: 0.67, blue: 0.424, alpha: 1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.bounds = self.bounds
        self.layer.position = self.center
        
        addSubview(labelView)
        labelView.anchor(leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         paddingLeading: 10,
                         paddingBottom: 10,
                         paddingTrailing: 10)
        
        addSubview(buttonImageView)
        buttonImageView.centerX(inView: self)
        buttonImageView.anchor(bottom: labelView.topAnchor, paddingBottom: 10)
    }
    
    func updateCookingOptions(withImage image: UIImage, text: String) {
        
        self.buttonImageView.image = image
        self.labelView.text = text
    }
    
}
