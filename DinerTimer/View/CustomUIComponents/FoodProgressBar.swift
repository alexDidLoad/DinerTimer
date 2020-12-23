//
//  FoodProgressBar.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/12/20.
//

import UIKit

class FoodProgressBar: UIView {
    
    //MARK: - UIComponents
    
    private let line: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = #colorLiteral(red: 0.2684969306, green: 0.2308473587, blue: 0.1689801216, alpha: 1)
        lineView.setHeight(height: 8)
        return lineView
    }()
    
    let firstBubble: ProgressBarBubble = {
        let bubble = ProgressBarBubble(withImage: nil)
        bubble.setDimensions(height: 44, width: 44)
        return bubble
    }()
    
    let secondBubble: ProgressBarBubble = {
        let bubble = ProgressBarBubble(withImage: nil)
        bubble.setDimensions(height: 44, width: 44)
        return bubble
    }()
    
    let thirdBubble: ProgressBarBubble = {
        let bubble = ProgressBarBubble(withImage: nil)
        bubble.setDimensions(height: 44, width: 44)
        return bubble
    }()
    
    let lastBubble: ProgressBarBubble = {
        let bubble = ProgressBarBubble(withImage: UIImage(systemName: "bell"))
        bubble.tintColor = .black
        bubble.setDimensions(height: 44, width: 44)
        return bubble
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc private func handleFirstPressed() {
        print("First Pressed")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = #colorLiteral(red: 0.9335944057, green: 0.6621651053, blue: 0.7384092212, alpha: 1)
        
        addSubview(line)
        line.anchor(top: self.topAnchor,
                    leading: self.leadingAnchor,
                    trailing: self.trailingAnchor,
                    paddingTop: 47,
                    paddingLeading: 24,
                    paddingTrailing: 24)
        
        addSubview(firstBubble)
        firstBubble.centerY(inView: line)
        firstBubble.anchor(leading: line.leadingAnchor)
        
        addSubview(secondBubble)
        secondBubble.centerY(inView: line)
        secondBubble.anchor(leading: firstBubble.trailingAnchor, paddingLeading: 58)
        
        addSubview(thirdBubble)
        thirdBubble.centerY(inView: line)
        thirdBubble.anchor(leading: secondBubble.trailingAnchor, paddingLeading: 51)
        
        addSubview(lastBubble)
        lastBubble.centerY(inView: line)
        lastBubble.anchor(trailing: line.trailingAnchor)
    }
}
