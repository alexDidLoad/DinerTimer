//
//  ViewController.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/11/20.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - UIComponents
    
    private let optionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose your breakfast item"
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Regular", size: 18)
        label.textColor = #colorLiteral(red: 0.1545568705, green: 0.117007874, blue: 0.04884755611, alpha: 1)
        label.setHeight(height: 21)
        return label
    }()
    
    //MARK: - Properties
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    //MARK: - Selectors
    
    
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        configureNavBar(withTitle: "Diner Timer", prefersLargeTitle: false)
        
        let backgroundImageView = UIImageView()
        backgroundImageView.setDimensions(height: view.frame.height, width: view.frame.width)
        drawCheckerBoard(imageView: backgroundImageView)
        view.addSubview(backgroundImageView)
        backgroundImageView.centerX(inView: view)
        backgroundImageView.centerY(inView: view)
        
        //bottomView
        let progressBar = FoodProgressBar()
        progressBar.setHeight(height: 265)
        view.addSubview(progressBar)
        progressBar.centerX(inView: view)
        progressBar.anchor(leading: view.leadingAnchor,
                           bottom: view.bottomAnchor,
                           trailing: view.trailingAnchor)
        
        view.addSubview(optionsLabel)
        optionsLabel.centerY(inView: progressBar, constant: -15)
        optionsLabel.anchor(leading: progressBar.leadingAnchor,
                            trailing: progressBar.trailingAnchor)
        
        //this needs to be changed
//        let foodItemView = FoodItemView()
//        view.addSubview(foodItemView)
//        foodItemView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
//                            leading: view.leadingAnchor,
//                            bottom: progressBar.topAnchor,
//                            trailing: view.trailingAnchor)
        let descriptionButton = DescriptionButton(name: "Over easy", description: "Whites are cooked through with runny yolk", estimatedTime: "3 min")
        view.addSubview(descriptionButton)
        descriptionButton.centerX(inView: view)
        descriptionButton.centerY(inView: view)
        
//        let quicktipView = QuickTipView()
//        view.addSubview(quicktipView)
//        quicktipView.centerX(inView: view)
//        quicktipView.centerY(inView: view)
//
        
    }
    
    
}


