
import UIKit
import ChameleonFramework

class AppSettings {
    
    static let instance = AppSettings()
    
    var styles = [AppStyle]()
    
    var primaryColor: UIColor?
    
    var subColor: UIColor?
    
    var titleTextColor: UIColor?
    
    var touchableColor: UIColor?
    
    var untouchableColor: UIColor?
    
    private init() {
        self.styles = AppSettings.defaultStyles()
        
        if let style = self.styles.first {
            
            self.primaryColor = HexColor(style.primary)
            
            self.subColor = HexColor(style.sub)
            
            self.titleTextColor = HexColor(style.title)
            
            self.touchableColor = HexColor(style.touchable)
            
            self.untouchableColor = HexColor(style.untouchable)
        }
    }
    
    private class func defaultStyles() -> [AppStyle] {
        
        var list = [AppStyle]()
        
        list.append(AppStyle(primary: "FCE38A",
                             sub: "F38181",
                             title: "808080",
                             touchable: "1EAAF1",
                             untouchable: "8CC152"))
        
        return list
    }
}
