
import Foundation

class TipInfo {
    
    var billMoney: Double = 0.00
    
    var tipPercentage: Float = 0.1
    
    var people: Int = 1
    
    var total: Double {
        get {
            return billMoney * Double(1.0 + tipPercentage)
        }
    }
    
    var payMoney: Double {
        get {
            return self.total / Double(people)
        }
    }
    
    init() {
        tipPercentage = AppSettings.instance.tipSettings.tip
        
        people = AppSettings.instance.tipSettings.people
    }
    
}
