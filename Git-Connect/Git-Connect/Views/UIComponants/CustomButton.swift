//
//  CustomButton.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    @IBInspectable var normalBackgroundColor: UIColor?
    @IBInspectable var highlightedBackgroundColor: UIColor?
    @IBInspectable var disableBackgroundColor: UIColor?
    
    @IBInspectable public var showBorderOnHighlight: Bool = false
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setCornerRadius(cornerRadius)
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : normalBackgroundColor
            
            if showBorderOnHighlight {
                self.layer.borderWidth = 2
                self.layer.borderColor = normalBackgroundColor?.cgColor
            }
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? normalBackgroundColor : disableBackgroundColor
            
            if showBorderOnHighlight {
                self.layer.borderWidth = 2
                if isEnabled {
                    self.layer.borderColor = normalBackgroundColor?.cgColor
                } else {
                    self.layer.borderColor = disableBackgroundColor?.cgColor
                }
            }
        }
    }
}

