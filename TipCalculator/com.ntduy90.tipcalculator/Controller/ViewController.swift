

import UIKit
import ChameleonFramework

class ViewController: UIViewController {
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var billSubItemView: ItemButtonView!
    @IBOutlet weak var tipSubItemView: ItemButtonView!
    @IBOutlet weak var peopleSubItemView: ItemButtonView!
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var numberKeyboard: NumberKeyboardView!
    
    let transition = BubbleTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        billSubItemView.delegate = self
        
        tipSubItemView.delegate = self
        
        peopleSubItemView.delegate = self
        
        numberKeyboard.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
//        print("Did layout subviews")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initBackground()
        
        initNavigationBarStyle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination
        
        controller.transitioningDelegate = self
        
        controller.modalPresentationStyle = .custom
    }
    
    @IBOutlet weak var background: UIView!
    
    func initBackground() {
        let backgroundLayer = applyGradient(colours: [AppSettings.instance.primaryColor!, AppSettings.instance.subColor!])
        
        background.backgroundColor = UIColor.clear
        
        background.layer.addSublayer(backgroundLayer)
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
        print("Show popup")
        self.view.bringSubview(toFront: popupView)
        
        popupView.isHidden = false
    }
    
    fileprivate func hidePopup() {
        print("Hide popup")
        self.view.sendSubview(toBack: popupView)
        
        popupView.isHidden = true
    }

}

extension ViewController: NumberKeyboardViewDelegate {
    
    func numberKeyboardSendValue(_ number: Double) {
        print(number)
    }
    
    func numberKeyboardSendText(_ text: String) {
        print(text)
    }
    
    func numberKeyboardDone() {
        
        self.hidePopup()
    }
    
}

extension ViewController: ItemButtonViewDelegate {
    
    func didChoose(type itemType: ItemType, from itemView: ItemButtonView) {
        
        self.showPopup()
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

