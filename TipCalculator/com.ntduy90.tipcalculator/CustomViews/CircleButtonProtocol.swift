//
//  CircleButtonProtocol.swift
//  TipCalculator
//
//  Created by Duy Nguyen on 6/3/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import Foundation

enum ActionType {
    
    case tap
    
    case chooseNumber(Int)
    
    case chooseText(String)
    
    case done
    
    case clear
    
    case remove
}

protocol CircleButtonDelegate {
    
    func circleButtonDid(on type:ActionType)
}

