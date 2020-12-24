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
    
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "test"
        return label
    }()
    
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
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setDimensions(height: 14, width: 49)
        button.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setDimensions(height: 14, width: 59)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    //MARK: - Properties
    
    weak var delegate: BottomTimerViewDelegate?
    
    private var soundEffect: AVAudioPlayer!
    
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
        buttonSoundEffect()
        button.liftUp()
    }
    
    @objc private func handlePause(button: UIButton) {
        delegate?.handlePause()
        playButton.isHidden = false
        pauseButton.isHidden = true
        buttonSoundEffect()
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
    
    private func buttonSoundEffect() {
        guard let url = Bundle.main.url(forResource: "buttonTock", withExtension: ".mp3") else { return }
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            soundEffect.play()
        } catch {
            print("DEBUG: Failed to play sound effect: \(error.localizedDescription)")
        }
    }
    
    private func configureUI() {
        self.backgroundColor = #colorLiteral(red: 0.9293814301, green: 0.6980805993, blue: 0.7606970668, alpha: 1)
        
        addSubview(playButton)
        playButton.centerX(inView: self)
        playButton.centerY(inView: self)
        
        addSubview(pauseButton)
        pauseButton.isHidden = true
        pauseButton.centerX(inView: self)
        pauseButton.centerY(inView: self)
        
        addSubview(itemLabel)
        itemLabel.anchor(top: self.topAnchor,
                         bottom: playButton.topAnchor)
        itemLabel.centerX(inView: self)
        
        addSubview(resetButton)
        resetButton.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor,
                           trailing: self.trailingAnchor,
                           paddingTrailing: 24)
        
        addSubview(cancelButton)
        cancelButton.anchor(leading: self.leadingAnchor,
                            bottom: self.safeAreaLayoutGuide.bottomAnchor,
                            paddingLeading: 24)
    }
}
