import UIKit

public extension UISearchBar {
    
    func change(textFont : UIFont?, textColor: UIColor?, textFieldColor : UIColor) {
        for view : UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                
                textField.backgroundColor = textFieldColor
                
                if textFont != nil { textField.font = textFont }
                if textColor != nil { textField.textColor = textColor }
            }
        }
    }
}
