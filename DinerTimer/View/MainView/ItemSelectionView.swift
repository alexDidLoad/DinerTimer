//
//  ButtonView.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/13/20.
//

import UIKit

protocol ItemSelectionViewDelegate: class {
    func didSelect()
}

class ItemSelectionView: UIView {
    
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
    
    private let panButton: CustomItemButton = {
        let button = CustomItemButton(withImage: UIImage(named: "pan"), text: "Pan fried")
        button.addTarget(self, action: #selector(handlePanPress), for: .touchUpInside)
        return button
    }()
    
    private let boilButton: CustomItemButton = {
        let button = CustomItemButton(withImage: UIImage(named: "boil"), text: "Boil")
        button.addTarget(self, action: #selector(handleBoilPress), for: .touchUpInside)
        return button
    }()
    
    private let ovenButton: CustomItemButton = {
        let button = CustomItemButton(withImage: UIImage(named: "oven"), text: "Bake")
        button.addTarget(self, action: #selector(handleOvenPress), for: .touchUpInside)
        return button
    }()
    
    private var topStack: UIStackView!
    private var bottomStack: UIStackView!
    
    private var panLeadingAnchor: NSLayoutConstraint?
    private var panCenterXAnchor: NSLayoutConstraint?
    
    private var boilLeadingAnchor: NSLayoutConstraint?
    private var boilCenterXAnchor: NSLayoutConstraint?
    //MARK: - Properties
    
    weak var delegate: ItemSelectionViewDelegate?
    
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
        
        fade(out: topStack, bottomStack) {
            self.animateInMethods(topFirst: true)
        }
    }
    
    @objc private func handleBaconPress() {
        print("DEBUG: Bacon")
        
        fade(out: topStack, bottomStack) {
            self.animateInMethods(topFirst: true)
        }
    }
    
    @objc private func handlePancakesPress() {
        print("DEBUG: Pancake")
        
        fade(out: bottomStack, topStack) {
            self.animateInMethods(topFirst: false)
        }
    }
    
    @objc private func handlePotatoPress() {
        print("DEBUG: Potato")

        fade(out: bottomStack, topStack) {
            self.animateInMethods(topFirst: false)
        }
    }
    
    @objc private func handlePanPress() {
        print("DEBUG: Pan")
    }
    
    @objc private func handleBoilPress() {
        print("DEBUG: Boil")
    }
    
    @objc private func handleOvenPress() {
        print("DEBUG: Oven")
    }
    
    //MARK: - Helpers
    
    private func animateInMethods(topFirst: Bool) {
        let topDelay: Double
        let botDelay: Double
        
        if topFirst == true {
            topDelay = 0.5
            botDelay = 0.8
        } else {
            topDelay = 0.8
            botDelay = 0.5
        }
        NSLayoutDeactivate([panLeadingAnchor])
        NSLayoutActivate([panCenterXAnchor])
        UIView.animate(withDuration: 0.8, delay: topDelay, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveLinear) {
            self.layoutIfNeeded()
        }
        self.NSLayoutDeactivate([self.boilLeadingAnchor])
        self.NSLayoutActivate([self.boilCenterXAnchor])
        UIView.animate(withDuration: 0.8, delay: botDelay, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveLinear) {
            self.layoutIfNeeded()
        }
    }
    
    private func configureUI() {
        
        topStack = UIStackView(arrangedSubviews: [eggButton, baconButton])
        topStack.axis = .horizontal
        topStack.distribution = .equalSpacing
        addSubview(topStack)
        topStack.anchor(top: self.topAnchor,
                        leading: self.leadingAnchor,
                        trailing: self.trailingAnchor,
                        paddingTop: 66,
                        paddingLeading: 16,
                        paddingTrailing: 16)
        
        bottomStack = UIStackView(arrangedSubviews: [pancakesButton, potatoButton])
        bottomStack.axis = .horizontal
        bottomStack.distribution = .equalSpacing
        addSubview(bottomStack)
        bottomStack.anchor(top: topStack.bottomAnchor,
                           leading: topStack.leadingAnchor,
                           trailing: topStack.trailingAnchor,
                           paddingTop: 21)
        
        addSubview(panButton)
        panButton.anchor(top: self.topAnchor,
                         paddingTop: 66)
        panLeadingAnchor = panButton.leadingAnchor.constraint(equalTo: self.trailingAnchor)
        panLeadingAnchor?.isActive = true
        panCenterXAnchor = panButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        panCenterXAnchor?.isActive = false
        
        addSubview(boilButton)
        boilButton.anchor(top: panButton.bottomAnchor,
                          paddingTop: 21)
        boilLeadingAnchor = boilButton.leadingAnchor.constraint(equalTo: self.trailingAnchor)
        boilLeadingAnchor?.isActive = true
        boilCenterXAnchor = boilButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        boilCenterXAnchor?.isActive = false
    }
    
}
