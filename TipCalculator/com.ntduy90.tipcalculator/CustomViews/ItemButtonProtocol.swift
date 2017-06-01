
import Foundation

enum ItemType {
    
    case undefined, bill, tip, people, pay
    
}

protocol ItemButtonViewDelegate {
    
    func didChoose(type itemType: ItemType, from itemView: ItemButtonView)
    
}
