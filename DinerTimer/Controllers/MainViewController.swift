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
    
    let progressBar = FoodProgressBar()
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
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
        
        let itemSelectionView = ItemSelectionView()
        itemSelectionView.delegate = self
        view.addSubview(itemSelectionView)
        itemSelectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                 bottom: progressBar.topAnchor)
        itemSelectionView.centerX(inView: view, leadingAnchor: view.leadingAnchor)
    }
}

//MARK: - ItemSelectionViewDelegate

extension MainViewController: ItemSelectionViewDelegate {
    
    func changeThirdProgressBubble() {
        progressBar.thirdBubble.bubbleImageView.image = UIImage(named: "cooking")
    }
    
    func changeProgressBarMethod(withMethod method: String) {
        progressBar.secondBubble.bubbleImageView.image = UIImage(named: method)
    }
    
    func changeProgressBarItem(withItem item: String) {
        progressBar.firstBubble.bubbleImageView.image = UIImage(named: item)
    }
    
    func didSelect() {
        let timerVC = TimerViewController()
        navigationController?.pushViewController(timerVC, animated: true)
    }
    
}
