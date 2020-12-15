//
//  PaddingLabel.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/15/20.
//

import UIKit

class PaddingLabel: UILabel {
    
    //MARK: - Properties
    
    var insets = UIEdgeInsets.zero
        
    //MARK: - Helpers
    
        func padding(_ top: CGFloat, _ bottom: CGFloat, _ leading: CGFloat, _ trailing: CGFloat) {
            self.frame = CGRect(x: 0, y: 0, width: self.frame.width + leading + trailing, height: self.frame.height + top + bottom)
            insets = UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
        }
        
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: insets))
        }
        
        override var intrinsicContentSize: CGSize {
            get {
                var contentSize = super.intrinsicContentSize
                contentSize.height += insets.top + insets.bottom
                contentSize.width += insets.left + insets.right
                return contentSize
            }
        }
    
}
