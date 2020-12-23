//
//  ButtonView.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/13/20.
//

import UIKit

protocol ItemSelectionViewDelegate: class {
    func didSelect()
    func changeProgressBarItem(withItem item: String)
    func changeProgressBarMethod(withMethod method: String)
    func changeThirdProgressBubble()
}

class ItemSelectionView: UIView {
    
    //MARK: - UIComponents
    
    //item buttons
    private let eggButton: CustomItemButton = {
        let button = CustomItemButton(withImage: eggImage, text: "Eggs")
        button.addTarget(self, action: #selector(handleEggPress), for: .touchUpInside)
        return button
    }()
    
    private let baconButton: CustomItemButton = {
        let button = CustomItemButton(withImage: baconImage, text: "Bacon")
        button.addTarget(self, action: #selector(handleBaconPress), for: .touchUpInside)
        return button
    }()
    
    private let pancakesButton: CustomItemButton = {
        let button = CustomItemButton(withImage: pancakeImage, text: "Pancakes")
        button.addTarget(self, action: #selector(handlePancakesPress), for: .touchUpInside)
        return button
    }()
    
    private let potatoButton: CustomItemButton = {
        let button = CustomItemButton(withImage: hashbrownImage, text: "Hashbrowns")
        button.addTarget(self, action: #selector(handlePotatoPress), for: .touchUpInside)
        return button
    }()
    
    //method option buttons
    private let topOptionButton: CustomItemButton = {
        let button = CustomItemButton()
        button.addTarget(self, action: #selector(handleTopPress), for: .touchUpInside)
        return button
    }()
    
    private let bottomOptionButton: CustomItemButton = {
        let button = CustomItemButton()
        button.addTarget(self, action: #selector(handleBottomPress), for: .touchUpInside)
        return button
    }()
    
    //description buttons
    private let firstDescription: DescriptionButton = {
        let button = DescriptionButton()
        button.addTarget(self, action: #selector(handleFirstPressed), for: .touchUpInside)
        return button
    }()
    
    private let secondDescription: DescriptionButton = {
        let button = DescriptionButton()
        button.addTarget(self, action: #selector(handleSecondPressed), for: .touchUpInside)
        return button
    }()
    
    private let thirdDescription: DescriptionButton = {
        let button = DescriptionButton()
        button.addTarget(self, action: #selector(handleThirdPressed), for: .touchUpInside)
        return button
    }()
    
    private let fourthDescription: DescriptionButton = {
        let button = DescriptionButton()
        button.addTarget(self, action: #selector(handleFourthPressed), for: .touchUpInside)
        return button
    }()
    
    //stacks
    private var topStack: UIStackView!
    private var bottomStack: UIStackView!
    
    //anchors
    private var topOptionLeadingAnchor: NSLayoutConstraint!
    private var topOptionCenterXAnchor: NSLayoutConstraint!
    
    private var bottomOptionLeadingAnchor: NSLayoutConstraint!
    private var bottomOptionCenterXAnchor: NSLayoutConstraint!
    
    private var firstDescriptionLeadingAnchor: NSLayoutConstraint!
    private var firstDescriptionCenterXAnchor: NSLayoutConstraint!
    
    private var secondDescriptionLeadingAnchor: NSLayoutConstraint!
    private var secondDescriptionCenterXAnchor: NSLayoutConstraint!
    
    private var thirdDescriptionLeadingAnchor: NSLayoutConstraint!
    private var thirdDescriptionCenterXAnchor: NSLayoutConstraint!
    
    private var fourthDescriptionLeadingAnchor: NSLayoutConstraint!
    private var fourthDescriptionCenterXAnchor: NSLayoutConstraint!
    //MARK: - Properties
    
    weak var delegate: ItemSelectionViewDelegate?
    
    private var firstPressed: Bool = false
    private var secondPressed: Bool = false
    private var thirdPressed: Bool = false
    private var fourthPressed: Bool = false
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
        delegate?.changeProgressBarItem(withItem: egg)
        breakfastItem.type = egg
        topOptionButton.updateCookingOptions(withImage: UIImage(named: "pan")!, text: "Pan fried")
        bottomOptionButton.updateCookingOptions(withImage: UIImage(named: "boil")!, text: "Boil / Poach")
        
        fade(out: topStack, [bottomStack]) {
            self.animateInOptions(topFirst: true)
        }
    }
    
    @objc private func handleBaconPress() {
        delegate?.changeProgressBarItem(withItem: bacon)
        breakfastItem.type = bacon
        topOptionButton.updateCookingOptions(withImage: UIImage(named: "pan")!, text: "Pan fried")
        bottomOptionButton.updateCookingOptions(withImage: UIImage(named: "oven")!, text: "Baked")
        
        fade(out: topStack, [bottomStack]) {
            self.animateInOptions(topFirst: true)
        }
    }
    
    @objc private func handlePancakesPress() {
        delegate?.changeProgressBarItem(withItem: pancake)
        breakfastItem.type = pancake
        topOptionButton.updateCookingOptions(withImage: UIImage(named: "pan")!, text: "Pan fried")
        bottomOptionButton.updateCookingOptions(withImage: UIImage(named: "oven")!, text: "Baked")
        
        fade(out: bottomStack, [topStack]) {
            self.animateInOptions(topFirst: false)
        }
    }
    
    @objc private func handlePotatoPress() {
        delegate?.changeProgressBarItem(withItem: hashbrown)
        breakfastItem.type = hashbrown
        topOptionButton.updateCookingOptions(withImage: UIImage(named: "pan")!, text: "Pan fried")
        bottomOptionButton.updateCookingOptions(withImage: UIImage(named: "oven")!, text: "Baked")
        
        fade(out: bottomStack, [topStack]) {
            self.animateInOptions(topFirst: false)
        }
    }
    
    @objc private func handleTopPress() {
        delegate?.changeProgressBarMethod(withMethod: pan)
        breakfastItem.method = pan
        updateTopButtonDescription(firstDescription,
                                   secondDescription,
                                   thirdDescription,
                                   fourthDescription)
        fade(out: topOptionButton, [bottomOptionButton]) {
            self.animateInDescriptions()
        }
    }
    
    @objc private func handleBottomPress() {
        if breakfastItem.type == egg {
            delegate?.changeProgressBarMethod(withMethod: boil)
            breakfastItem.method = boil
        } else {
            delegate?.changeProgressBarMethod(withMethod: oven)
            breakfastItem.method = oven
        }
        updateBottomButtonDescription(firstDescription,
                                      secondDescription,
                                      thirdDescription,
                                      fourthDescription)
        fade(out: bottomOptionButton, [topOptionButton]) {
            self.animateInDescriptions()
        }
    }
    
    @objc private func handleFirstPressed() {
        firstPressed = true
        updateDoneness()
        animateOutDescriptions()
    }
    
    @objc private func handleSecondPressed() {
        secondPressed = true
        updateDoneness()
        animateOutDescriptions()
    }
    
    @objc private func handleThirdPressed() {
        thirdPressed = true
        updateDoneness()
        animateOutDescriptions()
    }
    
    @objc private func handleFourthPressed() {
        fourthPressed = true
        updateDoneness()
        animateOutDescriptions()
    }
    
    @objc private func pushToTimerVC() {
        delegate?.didSelect()
    }
    
    //MARK: - Helpers
    
    private func updateDoneness() {
        if firstPressed {
            if breakfastItem.method == boil {
                breakfastItem.doneness = softBoil
            } else {
                switch breakfastItem.type {
                case egg:
                    breakfastItem.doneness = sunnyside
                case bacon:
                    breakfastItem.doneness = chewy
                default:
                    breakfastItem.doneness = light
                }
            }
        } else if secondPressed {
            if breakfastItem.method == boil {
                breakfastItem.doneness = mediumBoil
            } else {
                switch breakfastItem.type {
                case egg:
                    breakfastItem.doneness = overEasy
                case bacon:
                    breakfastItem.doneness = crispy
                case hashbrown:
                    breakfastItem.doneness = crispy
                default:
                    breakfastItem.doneness = brown
                }
            }
        } else if thirdPressed {
            if breakfastItem.method == boil {
                breakfastItem.doneness = hardBoil
            } else {
                switch breakfastItem.type {
                case egg:
                    breakfastItem.doneness = overMedium
                default:
                    breakfastItem.doneness = veryCrispy
                }
            }
        } else if fourthPressed {
            breakfastItem.doneness = overHard
        }
    }
    
    private func updateBottomButtonDescription(_ first: DescriptionButton, _ second: DescriptionButton, _ third: DescriptionButton, _ fourth: DescriptionButton) {
        if breakfastItem.type == egg {
            first.updateDescription(name: "Soft Boil",
                                    descriptionText: "Yolk is runny",
                                    estimatedTime: "6 min")
            second.updateDescription(name: "Medium Boil",
                                     descriptionText: "Yolk has fudge-like texture",
                                     estimatedTime: "8 min")
            third.updateDescription(name: "Hard Boil",
                                    descriptionText: "Yolk is set and chalky",
                                    estimatedTime: "12 min")
            fourth.isHidden = true
        } else if breakfastItem.type == bacon {
            first.updateDescription(name: "Chewspy",
                                    descriptionText: "Slightly crisp with chew",
                                    estimatedTime: "10 min")
            second.updateDescription(name: "Crispy",
                                     descriptionText: "The ideal version of bacon",
                                     estimatedTime: "13 min")
            third.updateDescription(name: "Very Crispy",
                                    descriptionText: "So crispy that it's almost like a chip",
                                    estimatedTime: "15 min")
            fourth.isHidden = true
        } else if breakfastItem.type == pancake {
            first.updateDescription(name: "Light",
                                    descriptionText: "Very little browning, soft",
                                    estimatedTime: "5 min")
            second.updateDescription(name: "Browned",
                                     descriptionText: "Hints of caramalize flavor, slightly firm",
                                     estimatedTime: "6 min")
            third.updateDescription(name: "Dark",
                                    descriptionText: "Smokey flavor, slightly bitter and crisp",
                                    estimatedTime: "7 min")
            fourth.isHidden = true
        } else if breakfastItem.type == hashbrown {
            first.updateDescription(name: "Light",
                                    descriptionText: "Slightly crisp, a bit mushy",
                                    estimatedTime: "20 min")
            second.updateDescription(name: "Crispy",
                                     descriptionText: "Crispy outside and slightly mushy inside",
                                     estimatedTime: "27 min")
            third.updateDescription(name: "Very Crispy",
                                    descriptionText: "Crispy inside and out",
                                    estimatedTime: "30 min")
            fourth.isHidden = true
        }
    }
    
    private func updateTopButtonDescription(_ first: DescriptionButton, _ second: DescriptionButton, _ third: DescriptionButton, _ fourth: DescriptionButton) {
        
        if breakfastItem.type == egg {
            first.updateDescription(name: "Sunny side up",
                                    descriptionText: "Yolk is runny and whites are just set",
                                    estimatedTime: "8 min")
            second.updateDescription(name: "Over Easy",
                                     descriptionText: "Egg is flipped, yolk is runny ",
                                     estimatedTime: "5 min")
            third.updateDescription(name: "Over Medium",
                                    descriptionText: "Egg is flipped, yolk is slightly firm",
                                    estimatedTime: "6 min")
            fourth.updateDescription(name: "Over Hard",
                                     descriptionText: "Egg is flipped, yolk is very firm",
                                     estimatedTime: "9 min")
        } else if breakfastItem.type == bacon {
            first.updateDescription(name: "Chewspy",
                                    descriptionText: "Slightly crisp with chew",
                                    estimatedTime: "8 min")
            second.updateDescription(name: "Crispy",
                                     descriptionText: "The ideal version of bacon",
                                     estimatedTime: "10 min")
            third.updateDescription(name: "Very Crispy",
                                    descriptionText: "So crispy that it's almost like a chip",
                                    estimatedTime: "12 min")
            fourth.isHidden = true
        } else if breakfastItem.type == pancake {
            first.updateDescription(name: "Light",
                                    descriptionText: "Very little browning, soft",
                                    estimatedTime: "2 min")
            second.updateDescription(name: "Browned",
                                     descriptionText: "Hints of caramalize flavor, slightly firm",
                                     estimatedTime: "3 min")
            third.updateDescription(name: "Dark",
                                    descriptionText: "Smokey flavor, slightly bitter and crisp",
                                    estimatedTime: "4 min")
            fourth.isHidden = true
        } else if breakfastItem.type == hashbrown {
            first.updateDescription(name: "Light",
                                    descriptionText: "Slightly crisp, a bit mushy",
                                    estimatedTime: "4 min")
            second.updateDescription(name: "Crispy",
                                     descriptionText: "Crispy outside and slightly mushy inside",
                                     estimatedTime: "6 min")
            third.updateDescription(name: "Very Crispy",
                                    descriptionText: "Crispy inside and out",
                                    estimatedTime: "7 min")
            fourth.isHidden = true
        }
    }
    
    private func animateOutDescriptions() {
        fade(out: firstDescription, [secondDescription, thirdDescription, fourthDescription])
        delegate?.changeThirdProgressBubble()
        perform(#selector(pushToTimerVC), with: nil, afterDelay: 1.5)
    }
    
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
        NSLayoutDeactivate([firstDescriptionLeadingAnchor])
        self.layoutIfNeeded()
        NSLayoutActivate([firstDescriptionCenterXAnchor])
        UIView.animate(withDuration: 0.8, delay: 0.3, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveLinear) {
            self.layoutIfNeeded()
        }
        NSLayoutDeactivate([secondDescriptionLeadingAnchor])
        self.layoutIfNeeded()
        NSLayoutActivate([secondDescriptionCenterXAnchor])
        UIView.animate(withDuration: 0.8, delay: 0.4, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveLinear) {
            self.layoutIfNeeded()
        }
        NSLayoutDeactivate([thirdDescriptionLeadingAnchor])
        self.layoutIfNeeded()
        NSLayoutActivate([thirdDescriptionCenterXAnchor])
        UIView.animate(withDuration: 0.8, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveLinear) {
            self.layoutIfNeeded()
        }
        NSLayoutDeactivate([fourthDescriptionLeadingAnchor])
        self.layoutIfNeeded()
        NSLayoutActivate([fourthDescriptionCenterXAnchor])
        UIView.animate(withDuration: 0.8, delay: 0.6, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveLinear) {
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
