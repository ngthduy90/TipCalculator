//
//  ItemView.swift
//  com.ntduy90.tipcalculator
//
//  Created by Duy Nguyen on 6/1/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit

class ItemView: UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

}
