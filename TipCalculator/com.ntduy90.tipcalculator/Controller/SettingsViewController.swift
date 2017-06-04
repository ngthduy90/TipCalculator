
import UIKit
import ChameleonFramework

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsHeaderBackgroundView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var firstThemeView: ItemView!
    
    @IBOutlet weak var secondThemeView: ItemView!
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var popupTitleLabel: UILabel!
    
    @IBOutlet weak var popupContentLabel: UILabel!
    
    @IBOutlet weak var numberKeyboard: NumberKeyboardView!
    
    @IBOutlet weak var tipPercentValueLabel: UILabel!
    
    @IBOutlet weak var peopleValueLabel: UILabel!
    
    var currentItemResponder: ItemType?
    
    let appSettings = AppSettings.instance
    
    let firstThemeStyle = AppSettings.instance.styles[0]
    
    let secondThemeStyle = AppSettings.instance.styles[1]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assignDelegate()
        
        displayListThemes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        displaySettings()
        
        backButton.layer.cornerRadius = 5.0
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = appSettings.touchableColor?.cgColor
        
        self.numberKeyboard.hidePrecisionKey()
        
        changeBackground()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func changeBackground() {
        
        settingsHeaderBackgroundView.applyGradient(colours: [AppSettings.instance.primaryColor!, AppSettings.instance.subColor!])
    }
    
    private func assignDelegate() {
        numberKeyboard.delegate = self
    }
    
    private func displayListThemes() {
        
        firstThemeView.applyGradient(colours: [HexColor(firstThemeStyle.primary)!, HexColor(firstThemeStyle.sub)!])
        
        secondThemeView.applyGradient(colours: [HexColor(secondThemeStyle.primary)!, HexColor(secondThemeStyle.sub)!])
    }
    
    fileprivate func displaySettings() {
        
        tipPercentValueLabel.text = "\(Int(appSettings.tipSettings.tip * 100))%"
        
        peopleValueLabel.text = "\(Int(appSettings.tipSettings.people))"
    }
    
    @IBAction func didTapTipView(_ sender: Any) {
        displayPopup("Tip percent", content: "\(Int(appSettings.tipSettings.tip * 100))%")
        
        currentItemResponder = ItemType.tip
    }
    
    @IBAction func didTapPeopleView(_ sender: Any) {
        displayPopup("People", content: "\(Int(appSettings.tipSettings.people))")
        
        currentItemResponder = ItemType.people
    }
    
    @IBAction func didTapFirstTheme(_ sender: Any) {
        appSettings.changeStyle(firstThemeStyle)
        
        changeBackground()
        
        numberKeyboard.rerenderKeyboard()
    }
    
    @IBAction func didTapSecondTheme(_ sender: Any) {
        appSettings.changeStyle(secondThemeStyle)
        
        changeBackground()
        
        numberKeyboard.rerenderKeyboard()
    }
        
    func showPopup() {
        self.view.bringSubview(toFront: popupView)
        
        popupView.isHidden = false
    }
    
    fileprivate func hidePopup() {
        self.view.sendSubview(toBack: popupView)
        
        popupView.isHidden = true
    }
    
    private func displayPopup(_ text: String, content ctnText: String) {
        
        popupTitleLabel.text = text
        
        popupContentLabel.text = ctnText
        
        showPopup()
    }
}

extension SettingsViewController: NumberKeyboardViewDelegate {
    
    func numberKeyboardSendValue(_ number: Double) {
        
        guard let itemType = currentItemResponder else {
            return
        }
        
        switch itemType {
            
        case .tip:
            appSettings.tipSettings.tip = Float(number / 100)
            self.popupContentLabel.text = "\(Int(appSettings.tipSettings.tip * 100))%"
            
        case .people:
            appSettings.tipSettings.people = Int(number)
            self.popupContentLabel.text = "\(appSettings.tipSettings.people)"
            
        default:
            return
        }
        
        displaySettings()
    }
    
    func numberKeyboardSendText(_ text: String) {
        //
    }
    
    func numberKeyboardFilterValue(_ number: Double) -> Bool {
        
        guard let itemType = currentItemResponder else {
            return true
        }
        
        switch itemType {
            
        case .tip, .people:
            return Int(number) <= 100
            
        default:
            return true
        }
    }
    
    func numberKeyboardDone() {
        
        self.hidePopup()
        
        self.numberKeyboard.resetValue()
    }
}






