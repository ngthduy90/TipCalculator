
import UIKit
import ChameleonFramework

class ItemButtonView: ItemView {

    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBInspectable var title: String? {
        get {
            return titleLabel.text
        }
        
        set(newText) {
            titleLabel.text = newText
        }
    }
    
    @IBInspectable var titleHexColor: String? {
        get {
            return titleLabel.textColor.hexValue()
        }
        
        set(hexString) {
            titleLabel.textColor = HexColor(hexString!)
        }
    }
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBInspectable var content: String? {
        get {
            return contentLabel.text
        }
        
        set(newText) {
            contentLabel.text = newText
        }
    }
    
    @IBInspectable var contentHexColor: String? {
        get {
            return contentLabel.textColor.hexValue()
        }
        
        set(hexString) {
            contentLabel.textColor = HexColor(hexString!)
        }
    }
    
    @IBOutlet weak var boundView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    var type = ItemType.undefined
    
    var delegate: ItemButtonViewDelegate?

    
    // MARK: - Actions
    
    @IBAction func didTap(_ sender: Any) {
        delegate?.didChoose(type: type, from: self)
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
    
    func renderView() {
        
        titleLabel.textColor = AppSettings.instance.titleTextColor
        
        contentLabel.textColor = AppSettings.instance.touchableColor
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
        
        renderView()
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}
