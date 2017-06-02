//
//  NumberKeyboardView.swift
//  TipCalculator
//
//  Created by Duy Nguyen on 6/3/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit

class NumberKeyboardView: UIView {
    
    @IBOutlet weak var btn0: CircleButtonView!
    @IBOutlet weak var btn1: CircleButtonView!
    @IBOutlet weak var btn2: CircleButtonView!
    @IBOutlet weak var btn3: CircleButtonView!
    @IBOutlet weak var btn4: CircleButtonView!
    @IBOutlet weak var btn5: CircleButtonView!
    @IBOutlet weak var btn6: CircleButtonView!
    @IBOutlet weak var btn7: CircleButtonView!
    @IBOutlet weak var btn8: CircleButtonView!
    @IBOutlet weak var btn9: CircleButtonView!
    
    @IBOutlet weak var clearButton: CircleButtonView!
    @IBOutlet weak var removeButton: CircleButtonView!
    @IBOutlet weak var doneButton: CircleButtonView!
    
    @IBOutlet weak var doubleZeroButton: CircleButtonView!
    @IBOutlet weak var dotButton: CircleButtonView!

    @IBOutlet weak var boundView: UIView!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
        
        defineButtonKeys()
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    fileprivate func defineButtonKeys() {
        
        btn0.actionType = ActionType.chooseNumber(0)
        btn0.delegate = self
        
        btn1.actionType = ActionType.chooseNumber(1)
        btn1.delegate = self
        
        btn2.actionType = ActionType.chooseNumber(2)
        btn2.delegate = self
        
        btn3.actionType = ActionType.chooseNumber(3)
        btn3.delegate = self
        
        btn4.actionType = ActionType.chooseNumber(4)
        btn4.delegate = self
        
        btn5.actionType = ActionType.chooseNumber(5)
        btn5.delegate = self
        
        btn6.actionType = ActionType.chooseNumber(6)
        btn6.delegate = self
        
        btn7.actionType = ActionType.chooseNumber(7)
        btn7.delegate = self
        
        btn8.actionType = ActionType.chooseNumber(8)
        btn8.delegate = self
        
        btn9.actionType = ActionType.chooseNumber(9)
        btn9.delegate = self
        
        dotButton.actionType = ActionType.chooseText(".")
        dotButton.delegate = self
        
        doubleZeroButton.actionType = ActionType.chooseText("00")
        doubleZeroButton.delegate = self
        
        clearButton.actionType = ActionType.clear
        clearButton.delegate = self
        
        removeButton.actionType = ActionType.remove
        removeButton.delegate = self
        
        doneButton.actionType = ActionType.done
        doneButton.delegate = self
    }
}

extension NumberKeyboardView: CircleButtonDelegate {
    
    func circleButtonDid(on type: ActionType) {
        
        switch type {
            
        case let .chooseNumber(selectedNumber):
            print(selectedNumber)
            
        case let .chooseText(selectedText):
            print(selectedText)
            
        case .clear:
            print("Clear")
            
        case .remove:
            print("Remove")
            
        case.done:
            print("Done")
            
        default:
            print("Default")
        }
    }
}
