//
//  TimerViewController.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/16/20.
//

import UIKit

class TimerViewController: UIViewController {
    
    //MARK: - UIComponents
    
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let backgroundImageView = UIImageView()
        backgroundImageView.setDimensions(height: view.frame.height, width: view.frame.width)
        drawCheckerBoard(imageView: backgroundImageView)
        view.addSubview(backgroundImageView)
        backgroundImageView.centerX(inView: view)
        backgroundImageView.centerY(inView: view)
        
        let quickTipView = QuickTipView()
        view.addSubview(quickTipView)
        quickTipView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            paddingTop: 33,
                            paddingLeading: 15,
                            paddingTrailing: 15)
        
        let timerView = PulsingTimer()
        view.addSubview(timerView)
        timerView.centerX(inView: view)
        timerView.centerY(inView: view)
        
        let bottomView = BottomTimerView()
        view.addSubview(bottomView)
        bottomView.setHeight(height: 217)
        bottomView.anchor(leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor)
    }
}
