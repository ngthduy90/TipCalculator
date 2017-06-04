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
    
    var delegate: NumberKeyboardViewDelegate?
    
    let defaultValueText: String! = "0"
    let defaultValueNumber = 0.00
    
    var havePrecision = false
    var precisionChar: String! = "."
    
    fileprivate var valueAsText: String! = ""
    fileprivate var valueAsNumber: Double?
    
    var listButtons = [CircleButtonView]()
    
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
        
        resetValue()
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func resetValue() {
        
        self.valueAsText = defaultValueText
        
        self.valueAsNumber = defaultValueNumber
        
        self.havePrecision = false
    }
    
    func showPrecisionKey() {
        self.dotButton.alpha = 1.0
    }
    
    func hidePrecisionKey() {
        self.dotButton.alpha = 0.0
    }
    
    func rerenderKeyboard() {
        
        listButtons.forEach {
            $0.renderView()
        }
    }
    
    fileprivate func defineButtonKeys() {
        
        btn0.actionType = ActionType.chooseText("0")
        btn0.delegate = self
        listButtons.append(btn0)
        
        btn1.actionType = ActionType.chooseText("1")
        btn1.delegate = self
        listButtons.append(btn1)
        
        btn2.actionType = ActionType.chooseText("2")
        btn2.delegate = self
        listButtons.append(btn2)
        
        btn3.actionType = ActionType.chooseText("3")
        btn3.delegate = self
        listButtons.append(btn3)
        
        btn4.actionType = ActionType.chooseText("4")
        btn4.delegate = self
        listButtons.append(btn4)
        
        btn5.actionType = ActionType.chooseText("5")
        btn5.delegate = self
        listButtons.append(btn5)
        
        btn6.actionType = ActionType.chooseText("6")
        btn6.delegate = self
        listButtons.append(btn6)
        
        btn7.actionType = ActionType.chooseText("7")
        btn7.delegate = self
        listButtons.append(btn7)
        
        btn8.actionType = ActionType.chooseText("8")
        btn8.delegate = self
        listButtons.append(btn8)
        
        btn9.actionType = ActionType.chooseText("9")
        btn9.delegate = self
        listButtons.append(btn9)
        
        dotButton.actionType = ActionType.chooseText(precisionChar)
        dotButton.delegate = self
        listButtons.append(dotButton)
        
        doubleZeroButton.actionType = ActionType.chooseText("00")
        doubleZeroButton.delegate = self
        listButtons.append(doubleZeroButton)
        
        clearButton.actionType = ActionType.clear
        clearButton.delegate = self
        listButtons.append(clearButton)
        
        removeButton.actionType = ActionType.remove
        removeButton.delegate = self
        listButtons.append(removeButton)
        
        doneButton.actionType = ActionType.done
        doneButton.delegate = self
        listButtons.append(doneButton)
    }
}

extension NumberKeyboardView: CircleButtonDelegate {
    
    func circleButtonDid(on type: ActionType) {
        
        switch type {
            
        case let .chooseNumber(selectedNumber):
            handleNumber(Double(selectedNumber))
            
        case let .chooseText(selectedText):
            handleText(selectedText)
            
        case .clear:
            resetValue()
            
        case .remove:
            handleRemoveLastCharacter()
            
        case.done:
            delegate?.numberKeyboardDone()
            return
            
        default:
            return
        }
        
        callDelegate()
    }
    
    fileprivate func callDelegate() {
        delegate?.numberKeyboardSendValue(valueAsNumber ?? defaultValueNumber)
        
        delegate?.numberKeyboardSendText(valueAsText ?? defaultValueText)
    }
    
    private func handleNumber(_ number: Double) {
        // ToDo: Need to implement in future
    }
    
    private func handleText(_ text: String) {
        
        guard !havePrecision || text != precisionChar else {
            return
        }
        
        let oldValueAsText = self.valueAsText
        
        if self.valueAsText.hasPrefix("0") {
            
            self.valueAsText = text
            
        } else {
            
            self.valueAsText.append(text)
            
        }
        
        if text == precisionChar {
            
            havePrecision = true
            
        }
        
        let newValue = (Double.init(self.valueAsText) ?? 0)
        
        if let filtered = delegate?.numberKeyboardFilterValue(newValue) {
            
            self.valueAsNumber = (filtered) ? newValue : self.valueAsNumber
            
            self.valueAsText = (filtered) ? self.valueAsText : oldValueAsText
            
        } else {
            
            self.valueAsNumber = newValue
        }
    }
    
    private func handleRemoveLastCharacter() {
        
        self.valueAsText.remove(at: valueAsText.index(before: valueAsText.endIndex))
        
        self.valueAsNumber = (Double.init(self.valueAsText) ?? 0)
        
        self.havePrecision = valueAsText.contains(precisionChar)
    }

}
