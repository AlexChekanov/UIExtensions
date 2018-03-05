import UIKit

public extension UIView {
    
    func informSizeWasUpdated(object: Any?, receivers: [UIView]? = nil, identifiers: [String]? = nil) {
        
        var userInfo: [AnyHashable: Any] = [:]
        
        if let receivers = receivers { userInfo["receivers"] = receivers }
        if let identifiers = identifiers {
            userInfo["identifiers"] = identifiers
        }
        
        let notification =  Notification(name: .sizeUpdateRequest, object: object, userInfo: userInfo)
        
        NotificationCenter.default.post(notification)
    }
}

public extension Notification.Name {
    
    static let viewWillTransition = Notification.Name("UIViewWillTransition")
    
    static let sizeUpdateRequest = Notification.Name("UIViewSizeUpdateRequested")
}

