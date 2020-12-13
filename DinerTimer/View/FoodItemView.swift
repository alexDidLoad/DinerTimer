//
//  ButtonView.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/13/20.
//

import UIKit

class FoodItemView: UIView {
    
    //MARK: - UIComponents
    
    private let eggButton: CustomItemButton = {
        let button = CustomItemButton(withImage: UIImage(named: "fried-egg"), text: "Eggs")
        button.addTarget(self, action: #selector(handleEggPress), for: .touchUpInside)
        return button
    }()
    
    private let baconButton: CustomItemButton = {
        let button = CustomItemButton(withImage: UIImage(named: "bacon"), text: "Bacon")
        button.addTarget(self, action: #selector(handleBaconPress), for: .touchUpInside)
        return button
    }()
    
    private let pancakesButton: CustomItemButton = {
        let button = CustomItemButton(withImage: UIImage(named: "pancakes"), text: "Pancakes")
        button.addTarget(self, action: #selector(handlePancakesPress), for: .touchUpInside)
        return button
    }()
    
    private let potatoButton: CustomItemButton = {
        let button = CustomItemButton(withImage: UIImage(named: "potatoes"), text: "Potatoes")
        button.addTarget(self, action: #selector(handlePotatoPress), for: .touchUpInside)
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
    
    @objc private func handleEggPress() {
        print("DEBUG: Egg")
    }
    
    @objc private func handleBaconPress() {
        print("DEBUG: Bacon")
    }
    
    @objc private func handlePancakesPress() {
        print("DEBUG: Pancake")
    }
    
    @objc private func handlePotatoPress() {
        print("DEBUG: Potato")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        
        let topStack = UIStackView(arrangedSubviews: [eggButton, baconButton])
        topStack.axis = .horizontal
        topStack.distribution = .equalSpacing
        addSubview(topStack)
        topStack.anchor(top: self.topAnchor,
                        leading: self.leadingAnchor,
                        trailing: self.trailingAnchor,
                        paddingTop: 66,
                        paddingLeading: 16,
                        paddingTrailing: 16)
        
        let bottomStack = UIStackView(arrangedSubviews: [pancakesButton, potatoButton])
        bottomStack.axis = .horizontal
        bottomStack.distribution = .equalSpacing
        addSubview(bottomStack)
        bottomStack.anchor(top: topStack.bottomAnchor,
                           leading: topStack.leadingAnchor,
                           trailing: topStack.trailingAnchor,
                           paddingTop: 21)
        
    }
    
    
    
}
