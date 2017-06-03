
import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsHeaderBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingsHeaderBackgroundView.applyGradient(colours: [AppSettings.instance.primaryColor!, AppSettings.instance.subColor!])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapTipView(_ sender: Any) {
        print("Tip")
    }
    
    @IBAction func didTapPeopleView(_ sender: Any) {
        print("People")
    }
}
