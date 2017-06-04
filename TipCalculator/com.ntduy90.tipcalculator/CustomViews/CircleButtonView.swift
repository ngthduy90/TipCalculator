
import UIKit

class CircleButtonView: UIView {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var boundView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    var actionType = ActionType.tap
    
    var delegate: CircleButtonDelegate?
    
    @IBInspectable var text: String? {
        get {
            return label.text
        }
        
        set(newText) {
            label.text = newText
        }
    }

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        renderView()
    }
    
    func renderView() {
        self.button.layer.borderColor = AppSettings.instance.primaryColor?.cgColor
        
        self.label.textColor = AppSettings.instance.keyboardColor
        
        self.button.layer.borderWidth = 1.0
        
        self.button.layer.cornerRadius = self.button.bounds.size.height * 0.5
    }
    
    // MARK: - Actions
    
    @IBAction func didTap(_ sender: Any) {
        self.delegate?.circleButtonDid(on: actionType)
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
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}
