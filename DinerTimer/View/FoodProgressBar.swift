//
//  FoodProgressBar.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/12/20.
//

import UIKit

class FoodProgressBar: UIView {
    
    //MARK: - UIComponents
    
    private let line: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = #colorLiteral(red: 0.2684969306, green: 0.2308473587, blue: 0.1689801216, alpha: 1)
        lineView.setHeight(height: 8)
        return lineView
    }()
    
    private let firstButton: ProgressBarButton = {
        let button = ProgressBarButton(withImage: nil)
        button.setDimensions(height: 44, width: 44)
        return button
    }()
    
    private let secondButton: ProgressBarButton = {
        let button = ProgressBarButton(withImage: nil)
        button.setDimensions(height: 44, width: 44)
        return button
    }()
    
    private let thirdButton: ProgressBarButton = {
        let button = ProgressBarButton(withImage: nil)
        button.setDimensions(height: 44, width: 44)
        return button
    }()
    
    private let lastButton: ProgressBarButton = {
        let button = ProgressBarButton(withImage: nil)
        button.setDimensions(height: 44, width: 44)
        return button
    }()
    
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
        print("First Pressed")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .red
        
        addSubview(line)
        line.centerY(inView: self)
        line.anchor(leading: leadingAnchor, trailing: trailingAnchor)
        
        addSubview(firstButton)
        firstButton.centerY(inView: self)
        firstButton.anchor(leading: line.leadingAnchor)
        
        addSubview(secondButton)
        secondButton.centerY(inView: self)
        secondButton.anchor(leading: firstButton.trailingAnchor, paddingLeading: 58)
        
        addSubview(thirdButton)
        thirdButton.centerY(inView: self)
        thirdButton.anchor(leading: secondButton.trailingAnchor, paddingLeading: 51)
        
        addSubview(lastButton)
        lastButton.centerY(inView: self)
        lastButton.anchor(trailing: line.trailingAnchor)
    }
}
