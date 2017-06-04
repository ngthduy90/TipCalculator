

import UIKit
import ChameleonFramework

class ViewController: UIViewController {
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var resetInfoButton: UIButton!
    
    @IBOutlet weak var totalMoneyLabel: UILabel!
    
    @IBOutlet weak var billSubItemView: ItemButtonView!
    
    @IBOutlet weak var tipSubItemView: ItemButtonView!
    
    @IBOutlet weak var peopleSubItemView: ItemButtonView!
    
    @IBOutlet weak var payMoneyView: ItemButtonView!
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var popupTitleLabel: UILabel!
    
    @IBOutlet weak var popupContentLabel: UILabel!
    
    @IBOutlet weak var numberKeyboard: NumberKeyboardView!
    
    let transition = BubbleTransition()
    
    var tipInfo = TipInfo()
    
    var currencyFormat: String! = ""
    
    var currentItemResponder: ItemType?
    
    let formatter = NumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignDelegate()
        
        currencyFormat = AppSettings.instance.tipSettings.currencyFormat
        
        formatter.numberStyle = .currency
        
        formatter.maximumFractionDigits = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initBackground()
        
        initNavigationBarStyle()
        
        refreshInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination
        
        controller.transitioningDelegate = self
        
        controller.modalPresentationStyle = .custom
    }
    
    private func assignDelegate() {
        
        billSubItemView.delegate = self
        billSubItemView.type = .bill
        
        tipSubItemView.delegate = self
        tipSubItemView.type = .tip
        
        peopleSubItemView.delegate = self
        peopleSubItemView.type = .people
        
        numberKeyboard.delegate = self
    }
    
    fileprivate func refreshInfo() {
        
        tipSubItemView.content = "\(Int(tipInfo.tipPercentage * 100))%"
        
        peopleSubItemView.content = "\(tipInfo.people)"
        
        billSubItemView.content = formatter.string(from: tipInfo.billMoney as NSNumber)
        
        totalMoneyLabel.text = formatter.string(from: tipInfo.total as NSNumber)
        
        payMoneyView.content = formatter.string(from: tipInfo.payMoney as NSNumber)
    }
    
    @IBAction func didTapResetInfo(_ sender: Any) {
        tipInfo = TipInfo()
        
        refreshInfo()
    }
    
    @IBOutlet weak var background: UIView!
    
    func initBackground() {
        
        background.applyGradient(colours: [AppSettings.instance.primaryColor!, AppSettings.instance.subColor!])
    }
    
    func initNavigationBarStyle() {
        self.navigationController?
            .navigationBar
            .titleTextAttributes = [NSForegroundColorAttributeName : AppSettings.instance.titleTextColor!]
    }

    func applyGradient(colours: [UIColor]) -> CALayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = self.view.frame
        
        gradient.colors = colours.map { $0.cgColor }
        
        return gradient
    }
    
    func showPopup() {
        self.view.bringSubview(toFront: popupView)
        
        popupView.isHidden = false
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    fileprivate func hidePopup() {
        self.view.sendSubview(toBack: popupView)
        
        currentItemResponder = nil
        
        popupView.isHidden = true
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension ViewController: NumberKeyboardViewDelegate {
    
    func numberKeyboardSendValue(_ number: Double) {
        
        guard let itemType = currentItemResponder else {
            return
        }
        
        switch itemType {
            
        case .bill:
            self.tipInfo.billMoney = number
            self.popupContentLabel.text = String(format: currencyFormat, tipInfo.billMoney)
            
        case .tip:
            self.tipInfo.tipPercentage = Float(number / 100)
            self.popupContentLabel.text = "\(Int(tipInfo.tipPercentage * 100))%"
            
        case .people:
            self.tipInfo.people = Int(number)
            self.popupContentLabel.text = "\(tipInfo.people)"
            
        default:
            return
        }
        
        refreshInfo()
    }
    
    func numberKeyboardSendText(_ text: String) {
//        print(text)
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

extension ViewController: ItemButtonViewDelegate {
    
    func didChoose(type itemType: ItemType, from itemView: ItemButtonView) {
        
        currentItemResponder = itemType
        
        switch itemType {
            
        case .tip, .people:
            self.numberKeyboard.hidePrecisionKey()
        default:
            self.numberKeyboard.showPrecisionKey()
        }
        
        changeTitlePopup(by: itemType)
        
        self.showPopup()
    }
    
    private func changeTitlePopup(by type: ItemType) {
        
        switch type {
            
        case .tip:
            self.popupTitleLabel.text = "Tip percent"
            self.popupContentLabel.text = "\(Int(tipInfo.tipPercentage * 100))%"
            
        case .bill:
            self.popupTitleLabel.text = "Bill"
            self.popupContentLabel.text = String(format: currencyFormat, tipInfo.billMoney)
            
        case .people:
            self.popupTitleLabel.text = "No. of people"
            self.popupContentLabel.text = "\(tipInfo.people)"
            
        default:
            self.popupTitleLabel.text = ""
            self.popupContentLabel.text = ""
        }
        
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .present
        transition.startingPoint = settingsButton.center
        transition.bubbleColor = AppSettings.instance.primaryColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .dismiss
        transition.startingPoint = settingsButton.center
        transition.bubbleColor = AppSettings.instance.primaryColor!
        
        return transition
    }
}

