//
//  DescriptionView.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/17/20.
//

import UIKit

class DescriptionView: UIView {
    
    //MARK: - UIComponents
    
    private let firstDescription: DescriptionButton = {
        let button = DescriptionButton(name: nil, description: nil, estimatedTime: nil)
        button.addTarget(self, action: #selector(handleFirstPressed), for: .touchUpInside)
        return button
    }()
    
    private let secondDescription: DescriptionButton = {
        let button = DescriptionButton(name: nil, description: nil, estimatedTime: nil)
        button.addTarget(self, action: #selector(handleSecondPressed), for: .touchUpInside)
        return button
    }()
    
    private let thirdDescription: DescriptionButton = {
        let button = DescriptionButton(name: nil, description: nil, estimatedTime: nil)
        button.addTarget(self, action: #selector(handleThirdPressed), for: .touchUpInside)
        return button
    }()
    
    private let fourthDescription: DescriptionButton = {
        let button = DescriptionButton(name: nil, description: nil, estimatedTime: nil)
        button.addTarget(self, action: #selector(handleFourthPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc private func handleFirstPressed() {
        print("DEBUG: first press")
    }
    
    @objc private func handleSecondPressed() {
        print("DEBUG: second press")
    }
    
    @objc private func handleThirdPressed() {
        print("DEBUG: third press")
    }
    
    @objc private func handleFourthPressed() {
        print("DEBUG: fourth press")
    }

    //MARK: - Helpers
    
    private func configureUI() {
        
        addSubview(firstDescription)
        firstDescription.anchor(top: self.topAnchor,
                                paddingTop: 32)
        firstDescription.centerX(inView: self)
        
        addSubview(secondDescription)
        secondDescription.anchor(top: firstDescription.bottomAnchor,
                                 paddingTop: 22)
        secondDescription.centerX(inView: self)
        
        addSubview(thirdDescription)
        thirdDescription.anchor(top: secondDescription.bottomAnchor,
                                paddingTop: 22)
        thirdDescription.centerX(inView: self)
        
        addSubview(fourthDescription)
        fourthDescription.anchor(top: thirdDescription.bottomAnchor,
                                 paddingTop: 22)
        fourthDescription.centerX(inView: self)
        
    }
    
}
