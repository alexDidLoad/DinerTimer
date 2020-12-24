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
    
    private let maleBakerImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "maleBaker")
        return iv
    }()
    
    private let femaleBakerImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "femaleBaker")
        return iv
    }()
    
    let progressBar = FoodProgressBar()
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    //MARK: - Helpers
    
    private func animateImageUpwards() {
        let moveUp = CGAffineTransform(translationX: 0, y: -245)
        
        UIView.animate(withDuration: 1.0, delay: 0.8, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveEaseIn) {
            self.maleBakerImage.transform = moveUp
            self.femaleBakerImage.transform = moveUp
        } completion: { _ in
            UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: .zero, options: .curveEaseIn) {
                self.maleBakerImage.transform = .identity
                self.femaleBakerImage.transform = .identity
            }
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureNavBar(withTitle: "Diner Timer", prefersLargeTitle: false)
        
        let backgroundImageView = UIImageView()
        backgroundImageView.layer.zPosition = -2
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
        
        maleBakerImage.layer.zPosition = -1
        view.addSubview(maleBakerImage)
        maleBakerImage.anchor(top: progressBar.topAnchor,
                              leading: view.leadingAnchor,
                              paddingLeading: -30)
        
        femaleBakerImage.layer.zPosition = -1
        view.addSubview(femaleBakerImage)
        femaleBakerImage.anchor(top: progressBar.topAnchor,
                                trailing: view.trailingAnchor,
                                paddingTrailing: -30)
        
        
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
        animateImageUpwards()
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
        let transition: CATransition = CATransition()
        transition.duration = 0.7
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(timerVC, animated: true)
    }
    
}
