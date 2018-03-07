import UIKit

public protocol UIKeyboardResizeDelegate: class {
    
    var bottomConstraint: NSLayoutConstraint { get }
    var bottomConstraintInitialConstant: CGFloat { get }
    
    func subscribeToKeyboardNotifications()
}


public extension UIKeyboardResizeDelegate {
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: nil) { [weak self] (notification) in
            
            guard let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
            
            self?.bottomConstraint.constant = keyboardHeight + (self?.bottomConstraintInitialConstant ?? 0)
            
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: nil) { [weak self] (notification) in
            
            self?.bottomConstraint.constant = self?.bottomConstraintInitialConstant ?? 0
        }
    }
}
