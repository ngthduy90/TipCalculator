
import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsHeaderBackgroundView: UIView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assignDelegate()
        
        print("Setting screen")
        displayListThemes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        displaySettings()
        
        self.numberKeyboard.hidePrecisionKey()
        
        settingsHeaderBackgroundView.applyGradient(colours: [AppSettings.instance.primaryColor!, AppSettings.instance.subColor!])
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func assignDelegate() {
        numberKeyboard.delegate = self
    }
    
    private func displayListThemes() {
        
        firstThemeView.applyGradient(colours: [appSettings.primaryColor!, appSettings.subColor!])
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






