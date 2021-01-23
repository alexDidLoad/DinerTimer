//
//  BottomTimerView.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/20/20.
//

import UIKit
import AVFoundation

protocol BottomTimerViewDelegate: class {
    func handlePlay()
    func handleReset()
    func handlePause()
    func handleCancel()
}

class BottomTimerView: UIView {
    
    //MARK: - UIComponents
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.imageView?.setDimensions(height: 32, width: 32)
        button.tintColor = .black
        button.setDimensions(height: 88, width: 88)
        button.layer.cornerRadius = 88 / 2
        button.backgroundColor = #colorLiteral(red: 0.9881569743, green: 0.9569149613, blue: 0.8940123916, alpha: 1)
        button.layer.shadowColor = #colorLiteral(red: 0.8078035712, green: 0.67062217, blue: 0.4234850705, alpha: 1)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        button.layer.shadowOffset = CGSize(width: 2, height: 4)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        return button
    }()
    
    private let pauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.imageView?.setDimensions(height: 32, width: 32)
        button.tintColor = .black
        button.setDimensions(height: 88, width: 88)
        button.layer.cornerRadius = 88 / 2
        button.backgroundColor = #colorLiteral(red: 0.9881569743, green: 0.9569149613, blue: 0.8940123916, alpha: 1)
        button.layer.shadowColor = #colorLiteral(red: 0.8078035712, green: 0.67062217, blue: 0.4234850705, alpha: 1)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0
        button.layer.shadowOffset = CGSize(width: 2, height: 4)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RESET", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 13)
        button.setDimensions(height: 14, width: 49)
        button.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 13)
        button.setDimensions(height: 14, width: 59)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()

    //MARK: - Properties
    
    weak var delegate: BottomTimerViewDelegate?
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Selectors
    
    @objc private func handlePlay(button: UIButton) {
        delegate?.handlePlay()
        playButton.isHidden = true
        pauseButton.isHidden = false
        button.liftUp()
    }
    
    @objc private func handlePause(button: UIButton) {
        delegate?.handlePause()
        playButton.isHidden = false
        pauseButton.isHidden = true
        button.liftUp()
    }
    
    @objc private func handleReset() {
        delegate?.handleReset()
        pauseButton.isHidden = true
        playButton.isHidden = false
    }
    
    @objc private func handleCancel() {
        delegate?.handleCancel()
    }
    
    @objc func animateTouchDown(button: UIButton) {
        button.pushDown()
    }
    //MARK: - Helpers
    
    private func configureUI() {
        backgroundColor = #colorLiteral(red: 1, green: 0.7170290299, blue: 0.7009517906, alpha: 1)
        
        addSubview(playButton)
        playButton.centerX(inView: self)
        playButton.centerY(inView: self, constant: -20)
        
        addSubview(pauseButton)
        pauseButton.isHidden = true
        pauseButton.centerX(inView: self)
        pauseButton.centerY(inView: self, constant: -20)
        
        addSubview(resetButton)
        resetButton.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor,
                           trailing: self.trailingAnchor,
                           paddingBottom: 20,
                           paddingTrailing: 24)
        
        addSubview(cancelButton)
        cancelButton.anchor(leading: self.leadingAnchor,
                            bottom: self.safeAreaLayoutGuide.bottomAnchor,
                            paddingLeading: 24,
                            paddingBottom: 20)
    }
}
