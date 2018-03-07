import UIKit

public protocol UISizeUpdateDelegate: class {
    
    var sizeUpdateRequest: Notification.Name { get }
    var addresseeVerificationFunction: (Notification) -> Bool { get }
    var sizeUpdateFunction: (Bool) -> () { get }
    
    func subscribeToSizeUpdateRequests()
    
}

public extension UISizeUpdateDelegate {
    
    func subscribeToSizeUpdateRequests() {
        NotificationCenter.default.addObserver(forName: sizeUpdateRequest, object: nil, queue: nil) { [weak self] (notification) in
            
            guard let isAddressee = self?.addresseeVerificationFunction(notification) , isAddressee else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
                self?.sizeUpdateFunction(false)
            })
        }
    }
    
}
