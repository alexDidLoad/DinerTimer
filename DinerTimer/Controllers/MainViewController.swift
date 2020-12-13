//
//  ViewController.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/11/20.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - UIComponents
    
    private let bottomView: UIView = {
        let bv = UIView()
        bv.setHeight(height: 265)
        bv.backgroundColor = #colorLiteral(red: 0.9335944057, green: 0.6621651053, blue: 0.7384092212, alpha: 1)
        return bv
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
        configureNavBar(withTitle: "Diner Timer", prefersLargeTitle: true)
        
        let backgroundImageView = UIImageView()
        backgroundImageView.setDimensions(height: view.frame.height, width: view.frame.width)
        drawCheckerBoard(imageView: backgroundImageView)
        view.addSubview(backgroundImageView)
        backgroundImageView.centerX(inView: view)
        backgroundImageView.centerY(inView: view)
       
        view.addSubview(bottomView)
        bottomView.anchor(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        let progressBar = FoodProgressBar()
        bottomView.addSubview(progressBar)
        progressBar.anchor(top: bottomView.topAnchor, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor, paddingTop: 45, paddingLeading: 24, paddingTrailing: 24)
        
        
    }
    
    
}


