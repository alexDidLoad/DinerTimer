//
//  TimerViewController.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/16/20.
//

import UIKit
import UserNotifications
import AVFoundation

class TimerViewController: UIViewController {
    
    //MARK: - UIComponents
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Heavy", size: 12)
        label.numberOfLines = 0
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        return label
    }()
    
    private let tempView: UIView = {
        let view = UIView()
        let iv = UIImageView()
        iv.image = UIImage(systemName: "thermometer")
        view.addSubview(iv)
        iv.setDimensions(height: 45, width: 30)
        iv.anchor(top: view.topAnchor, leading: view.leadingAnchor, paddingTop: 2, paddingLeading: 1)
        iv.tintColor = UIColor.systemRed.withAlphaComponent(0.8)
        view.backgroundColor = #colorLiteral(red: 0.9881569743, green: 0.9569149613, blue: 0.8940123916, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.9466593862, green: 0.7775826454, blue: 0.4798718095, alpha: 1).cgColor
        view.setDimensions(height: 50, width: 95)
        view.layer.cornerRadius = 12
        return view
    }()
    
    //MARK: - Properties
    
    private var timerView = PulsingTimer()
    private var audioPlayer: AVAudioPlayer!
    
    private var isRunning: Bool = false
    private var hasPaused: Bool = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        updateTemperatureLabel()
        addNotificationObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        breakfastItem.type = nil
        breakfastItem.method = nil
        breakfastItem.doneness = nil
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    //MARK: - Selectors
    
    @objc private func updateTime() {
        if hasPaused && timerView.timeLeft > 0 {
            timerView.timeLeft = timerView.date!.timeIntervalSinceNow + (-timerView.savedTime)
            timerView.timerLabel.text = timerView.timeLeft.time
        } else if timerView.timeLeft > 0 {
            timerView.timeLeft = timerView.date?.timeIntervalSinceNow ?? 0
            timerView.timerLabel.text = timerView.timeLeft.time
        } else {
            timerView.timerLabel.text = "00:00"
            playAlarm()
            timerView.pulsingLayer.removeAnimation(forKey: "pulsing")
            timerView.timer.invalidate()
            
            let ac = UIAlertController(title: "Hey!", message: "\nDon't overcook it!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak self] _ in
                self?.audioPlayer?.stop()
            }))
            present(ac, animated: true)
        }
    }
    
    @objc func willEnterForeground() {
        if isRunning {
            timerView.pulsingLayer.add(timerView.pulsingAnimation, forKey: "pulsing")
        }
    }
    //MARK: - Notifications
    
    private func addNotificationObserver() {
        notificationCenter.addObserver(self, selector: #selector(self.willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func notificationAlert() {
        let content = UNMutableNotificationContent()
        content.title = "Food is ready!"
        content.body = "Don't let it burn!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData" : "Well Done"]
        content.sound = UNNotificationSound.default
        
        var trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval:
                                                                                            timerView.timeLeft,
                                                                                           repeats: false) {
            didSet { trigger = UNTimeIntervalNotificationTrigger(timeInterval: timerView.timeLeft,
                                                                 repeats: false)} }
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        userNotificationCenter.add(request)
    }
    //MARK: - Helpers
    
    private func updateTemperatureLabel() {
        switch breakfastItem.type {
        case egg:
            switch breakfastItem.method {
            case pan:
                switch breakfastItem.doneness {
                case sunnyside:
                    temperatureLabel.text = "Medium Heat"
                default:
                    temperatureLabel.text = "Medium High"
                }
            default:
                temperatureLabel.text = "High Heat"
            }
        case bacon:
            switch breakfastItem.method {
            case pan:
                temperatureLabel.text = "Medium High"
            default:
                temperatureLabel.text = "400℉"
            }
        case pancake:
            switch breakfastItem.method {
            case pan:
                temperatureLabel.text = "Medium Heat"
            default:
                temperatureLabel.text = "425℉"
            }
        default:
            switch breakfastItem.method {
            case pan:
                temperatureLabel.text = "Medium High"
            default:
                temperatureLabel.text = "400℉"
            }
        }
    }
    
    private func exitTimer() {
        if timerView.timerLabel.text == "00:00" || isRunning == false {
            navigationController?.popToRootViewController(animated: true)
        } else {
            let ac = UIAlertController(title: "Are you sure?", message: "Going back will reset the timer", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
                                        self?.navigationController?.popToRootViewController(animated: true)}
            ))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        }
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
    
    private func playAlarm() {
        guard let url = Bundle.main.url(forResource: "marimba", withExtension: ".mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = audioPlayer else { return }
            player.numberOfLoops = -1
            player.play()
        } catch {
            print("DEBUG: Failed to play alarm: \(error.localizedDescription)")
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Diner Timer"
        navigationItem.hidesBackButton = true
        
        let backgroundImageView = UIImageView()
        backgroundImageView.setDimensions(height: view.frame.height, width: view.frame.width)
        drawCheckerBoard(imageView: backgroundImageView)
        view.addSubview(backgroundImageView)
        backgroundImageView.centerX(inView: view)
        backgroundImageView.centerY(inView: view)
        
        let quickTipView = QuickTipView()
        view.addSubview(quickTipView)
        quickTipView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            paddingTop: 12)
        quickTipView.centerX(inView: view)
        
        view.addSubview(tempView)
        tempView.anchor(top: quickTipView.bottomAnchor,
                        trailing: quickTipView.trailingAnchor,
                        paddingTop: 6,
                        paddingTrailing: 6)
        
        tempView.addSubview(temperatureLabel)
        temperatureLabel.centerY(inView: tempView)
        temperatureLabel.anchor(leading: tempView.leadingAnchor,
                                trailing: tempView.trailingAnchor,
                                paddingLeading: 26)
        
        view.addSubview(timerView)
        timerView.backgroundColor = .green
        timerView.centerX(inView: view)
        timerView.centerY(inView: view)
        
        let bottomView = BottomTimerView()
        bottomView.delegate = self
        view.addSubview(bottomView)
        bottomView.anchor(top: view.centerYAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor,
                          paddingTop: 175)
    }
}
//MARK: - BottomTimerViewDelegate

extension TimerViewController: BottomTimerViewDelegate {
    
    func handlePlay() {
        if hasPaused == true {
            timerView.savedTime = Double(timerView.date!.timeIntervalSinceNow - timerView.timeLeft)
            timerView.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            if timerView.timeLeft > 0 {
                notificationAlert()
            }
            timerView.resumeAnimation()
        } else {
            timerView.startTime()
            timerView.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            notificationAlert()
            isRunning = true
        }
    }
    
    func handleReset() {
        timerView.timer.invalidate()
        timerView.timeLeft = timerView.calculator.calculateCookTime(for: breakfastItem.type,
                                                                    method: breakfastItem.method,
                                                                    doneness: breakfastItem.doneness)
        timerView.timerLabel.text = timerView.timeLeft.time
        timerView.progressLayer.removeFromSuperlayer()
        timerView.pulsingLayer.removeAnimation(forKey: "pulsing")
        isRunning = false
        hasPaused = false
    }
    
    func handlePause() {
        timerView.pauseAnimation()
        timerView.timer.invalidate()
        userNotificationCenter.removeAllPendingNotificationRequests()
        hasPaused = true
    }
    
    func handleCancel() {
        let name = Notification.Name(rawValue: notifyResetItems)
        notificationCenter.post(name: name, object: nil)
        exitTimer()
    }
}

