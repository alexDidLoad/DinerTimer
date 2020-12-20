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
    
    //item buttons
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
    
    //method option buttons
    private let topOptionButton: CustomItemButton = {
        let button = CustomItemButton(withImage: UIImage(named: "pan"), text: "Pan fried")
        button.addTarget(self, action: #selector(handleTopPress), for: .touchUpInside)
        return button
    }()
    
    private let bottomOptionButton: CustomItemButton = {
        let button = CustomItemButton(withImage: UIImage(named: "boil"), text: "Boil")
        button.addTarget(self, action: #selector(handleBottomPress), for: .touchUpInside)
        return button
    }()
    
    //description buttons
    private let firstDescription: DescriptionButton = {
        let button = DescriptionButton(name: "Sunny side up", descriptionText: "Runny yolk, not flipped", estimatedTime: "8 min")
        button.addTarget(self, action: #selector(handleFirstPressed), for: .touchUpInside)
        return button
    }()
    
    private let secondDescription: DescriptionButton = {
        let button = DescriptionButton(name: "Over Easy", descriptionText: "Runny yolk and flipped", estimatedTime: "5 min")
        button.addTarget(self, action: #selector(handleSecondPressed), for: .touchUpInside)
        return button
    }()
    
    private let thirdDescription: DescriptionButton = {
        let button = DescriptionButton(name: "Over Medium", descriptionText: "Yolk is slightly runny and whites are set", estimatedTime: "6 min")
        button.addTarget(self, action: #selector(handleThirdPressed), for: .touchUpInside)
        return button
    }()
    
    private let fourthDescription: DescriptionButton = {
        let button = DescriptionButton(name: "Over Hard", descriptionText: "Yolk is firm", estimatedTime: "9 min")
        button.addTarget(self, action: #selector(handleFourthPressed), for: .touchUpInside)
        return button
    }()
    
    //stacks
    private var topStack: UIStackView!
    private var bottomStack: UIStackView!
    
    //anchors
    private var topOptionLeadingAnchor: NSLayoutConstraint?
    private var topOptionCenterXAnchor: NSLayoutConstraint?
    
    private var bottomOptionLeadingAnchor: NSLayoutConstraint?
    private var bottomOptionCenterXAnchor: NSLayoutConstraint?
    
    private var firstDescriptionLeadingAnchor: NSLayoutConstraint?
    private var firstDescriptionCenterXAnchor: NSLayoutConstraint?
    
    private var secondDescriptionLeadingAnchor: NSLayoutConstraint?
    private var secondDescriptionCenterXAnchor: NSLayoutConstraint?
    
    private var thirdDescriptionLeadingAnchor: NSLayoutConstraint?
    private var thirdDescriptionCenterXAnchor: NSLayoutConstraint?
    
    private var fourthDescriptionLeadingAnchor: NSLayoutConstraint?
    private var fourthDescriptionCenterXAnchor: NSLayoutConstraint?
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
            self.animateInOptions(topFirst: true)
        }
    }
    
    @objc private func handleBaconPress() {
        print("DEBUG: Bacon")
        
        fade(out: topStack, bottomStack) {
            self.animateInOptions(topFirst: true)
        }
    }
    
    @objc private func handlePancakesPress() {
        print("DEBUG: Pancake")
        
        fade(out: bottomStack, topStack) {
            self.animateInOptions(topFirst: false)
        }
    }
    
    @objc private func handlePotatoPress() {
        print("DEBUG: Potato")
        fade(out: bottomStack, topStack) {
            self.animateInOptions(topFirst: false)
        }
    }
    
    @objc private func handleTopPress() {
        print("DEBUG: Pan")
        fade(out: topOptionButton, bottomOptionButton) {
            self.animateInDescriptions()
        }
    }
    
    @objc private func handleBottomPress() {
        print("DEBUG: Boil")
        fade(out: bottomOptionButton, topOptionButton) {
            self.animateInDescriptions()
        }
    }
    
    @objc private func handleFirstPressed() {
        print("DEBUG: first press")
        delegate?.didSelect()
    }
    
    @objc private func handleSecondPressed() {
        print("DEBUG: second press")
        delegate?.didSelect()
    }
    
    @objc private func handleThirdPressed() {
        print("DEBUG: third press")
        delegate?.didSelect()
    }
    
    @objc private func handleFourthPressed() {
        print("DEBUG: fourth press")
        delegate?.didSelect()
    }
    
    //MARK: - Helpers
    
    private func animateInOptions(topFirst: Bool) {
        let topDelay: Double
        let botDelay: Double
        
        if topFirst {
            topDelay = 0.4
            botDelay = 0.6
        } else {
            topDelay = 0.6
            botDelay = 0.4
        }
        NSLayoutDeactivate([topOptionLeadingAnchor])
        NSLayoutActivate([topOptionCenterXAnchor])
        UIView.animate(withDuration: 0.8, delay: topDelay, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveLinear) {
            self.layoutIfNeeded()
        }
        NSLayoutDeactivate([bottomOptionLeadingAnchor])
        NSLayoutActivate([bottomOptionCenterXAnchor])
        UIView.animate(withDuration: 0.8, delay: botDelay, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveLinear) {
            self.layoutIfNeeded()
        }
    }
    
    private func animateInDescriptions() {
        let leadingAnchors = [firstDescriptionLeadingAnchor, secondDescriptionLeadingAnchor, thirdDescriptionLeadingAnchor, fourthDescriptionLeadingAnchor]
        let centerXAnchors = [firstDescriptionCenterXAnchor, secondDescriptionCenterXAnchor, thirdDescriptionCenterXAnchor, fourthDescriptionCenterXAnchor]
        var delay = 0.4
        
        for leading in leadingAnchors {
            for centerX in centerXAnchors {
                NSLayoutDeactivate([leading])
                NSLayoutActivate([centerX])
                UIView.animate(withDuration: 0.8, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveLinear) {
                    self.layoutIfNeeded()
                }
                delay += 0.08
            }
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
        
        addSubview(topOptionButton)
        topOptionButton.anchor(top: self.topAnchor,
                               paddingTop: 66)
        topOptionLeadingAnchor = topOptionButton.leadingAnchor.constraint(equalTo: self.trailingAnchor)
        topOptionLeadingAnchor?.isActive = true
        topOptionCenterXAnchor = topOptionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        topOptionCenterXAnchor?.isActive = false
        
        addSubview(bottomOptionButton)
        bottomOptionButton.anchor(top: topOptionButton.bottomAnchor,
                                  paddingTop: 21)
        bottomOptionLeadingAnchor = bottomOptionButton.leadingAnchor.constraint(equalTo: self.trailingAnchor)
        bottomOptionLeadingAnchor?.isActive = true
        bottomOptionCenterXAnchor = bottomOptionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        bottomOptionCenterXAnchor?.isActive = false
        
        addSubview(firstDescription)
        firstDescription.anchor(top: self.topAnchor,
                                paddingTop: 32)
        firstDescriptionLeadingAnchor = firstDescription.leadingAnchor.constraint(equalTo: self.trailingAnchor)
        firstDescriptionLeadingAnchor?.isActive = true
        firstDescriptionCenterXAnchor = firstDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        firstDescriptionCenterXAnchor?.isActive = false
        
        addSubview(secondDescription)
        secondDescription.anchor(top: firstDescription.bottomAnchor,
                                 paddingTop: 22)
        secondDescriptionLeadingAnchor = secondDescription.leadingAnchor.constraint(equalTo: self.trailingAnchor)
        secondDescriptionLeadingAnchor?.isActive = true
        secondDescriptionCenterXAnchor = secondDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        secondDescriptionCenterXAnchor?.isActive = false
        
        addSubview(thirdDescription)
        thirdDescription.anchor(top: secondDescription.bottomAnchor,
                                paddingTop: 22)
        thirdDescriptionLeadingAnchor = thirdDescription.leadingAnchor.constraint(equalTo: self.trailingAnchor)
        thirdDescriptionLeadingAnchor?.isActive = true
        thirdDescriptionCenterXAnchor = thirdDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        thirdDescriptionCenterXAnchor?.isActive = false
        
        addSubview(fourthDescription)
        fourthDescription.anchor(top: thirdDescription.bottomAnchor,
                                 paddingTop: 22)
        fourthDescriptionLeadingAnchor = fourthDescription.leadingAnchor.constraint(equalTo: self.trailingAnchor)
        fourthDescriptionLeadingAnchor?.isActive = true
        fourthDescriptionCenterXAnchor = fourthDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        fourthDescriptionCenterXAnchor?.isActive = false
        
    }
    
}
