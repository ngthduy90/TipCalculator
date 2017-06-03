//
//  NumberKeyboardViewDelegate.swift
//  TipCalculator
//
//  Created by Duy Nguyen on 6/3/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import Foundation

protocol NumberKeyboardViewDelegate {
    
    func numberKeyboardSendText(_ text: String)
    
    func numberKeyboardSendValue(_ number: Double)
    
    func numberKeyboardFilterValue(_ number: Double) -> Bool
    
    func numberKeyboardDone()
    
}
