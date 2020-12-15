//
//  ProgressBarButtons.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/12/20.
//

import UIKit

class ProgressBarBubble: UIView {
    
    //MARK: - Properties
    
    private let bubbleImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(height: 22, width: 22)
        return iv
    }()
    
    //MARK: - Lifecycle
    
    init(withImage image: UIImage?) {
        super.init(frame: .zero)
        
        configureUI(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI(image: UIImage?) {
        self.backgroundColor = #colorLiteral(red: 0.9420526624, green: 0.7777841687, blue: 0.4800494313, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.2684969306, green: 0.2308473587, blue: 0.1689801216, alpha: 1)
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
        
        bubbleImageView.image = image
        addSubview(bubbleImageView)
        bubbleImageView.centerY(inView: self)
        bubbleImageView.centerX(inView: self)
    }
    
}
