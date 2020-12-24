//
//  TimerViewController.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/16/20.
//

import UIKit
import UserNotifications
import AVFoundation

let userNotificationCenter = UNUserNotificationCenter.current()

class TimerViewController: UIViewController {
    
    //MARK: - UIComponents
    
    
    //MARK: - Properties
    
    private var timerView = PulsingTimer()
    private let pulsingNotifcation = NotificationCenter.default
    private var audioPlayer: AVAudioPlayer!
    
    private var isRunning: Bool = false
    private var hasPaused: Bool = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addNotificationObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        breakfastItem.type = nil
        breakfastItem.method = nil
        breakfastItem.doneness = nil
    }
    
    deinit {
        pulsingNotifcation.removeObserver(self)
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
            
            let ac = UIAlertController(title: "Food's Ready", message: "\nDon't overcook it!", preferredStyle: .alert)
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
        pulsingNotifcation.addObserver(self, selector: #selector(self.willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
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
        guard let url = Bundle.main.url(forResource: "marimba", withExtension: ".wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = audioPlayer else { return }
            player.play()
        } catch {
            print("DEBUG: Failed to play alarm: \(error.localizedDescription)")
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureNavBar(withTitle: "\(breakfastItem.type.capitalized) | \(breakfastItem.method.capitalized) | \(breakfastItem.doneness.capitalized)",
                        prefersLargeTitle: false)
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
                            paddingTop: 33)
        quickTipView.centerX(inView: view)
        
        view.addSubview(timerView)
        timerView.centerX(inView: view)
        timerView.centerY(inView: view)
        
        let bottomView = BottomTimerView()
        bottomView.delegate = self
        view.addSubview(bottomView)
        bottomView.setHeight(height: 217)
        bottomView.anchor(leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor)
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
        exitTimer()
    }
}

