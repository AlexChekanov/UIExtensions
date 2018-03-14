import UIKit

public protocol UIResizeRequestDelegate: class {
    
    var resizeRequest: Notification.Name { get }
    var addresseeVerificationFunction: (Notification) -> Bool { get }
    var resizingFunction: (Bool) -> () { get }
    
    func subscribeToResizeRequests()
    
}

public extension UIResizeRequestDelegate {
    
    func subscribeToResizeRequests() {
        NotificationCenter.default.addObserver(forName: resizeRequest, object: nil, queue: nil) { [weak self] (notification) in
            
            guard let isAddressee = self?.addresseeVerificationFunction(notification) , isAddressee else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
                self?.resizingFunction(false)
            })
        }
    }
    
}
