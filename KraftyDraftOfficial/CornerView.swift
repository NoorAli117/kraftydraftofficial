//
//  CornerView.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 5/4/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable
class CornerView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
