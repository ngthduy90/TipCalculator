//
//  LayerUtils.swift
//  TipCalculator
//
//  Created by Duy Nguyen on 6/4/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyGradient(colours: [UIColor]) {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        
        gradient.colors = colours.map { $0.cgColor }
        
        self.layer.addSublayer(gradient)
    }
}
