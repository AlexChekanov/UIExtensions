import UIKit

public extension UIView {
    
    func checkIsAdressee(of notification: Notification) -> Bool {
        
        guard
            let data = notification.userInfo else { return false }
        
        if let receivers = data["receivers"] as? [UIView], receivers.contains(self) { return true }
        
        if let identifier = restorationIdentifier,
            let identifiers = data["identifiers"] as? [String],
            identifiers.contains(identifier)
        { return true }
        
        return false
    }
}
