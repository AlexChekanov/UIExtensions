import UIKit

public struct ScrollRequest {
    
    var rect: CGRect
    var view: UIView
    var animated: Bool
}

public protocol UIScrollRequestDelegate: class {
    
    var scrollRequest: Notification.Name { get }
    var addresseeVerificationFunction: (Notification) -> Bool { get }
    var scrollingFunction: (CGRect, UIView, Bool) -> () { get }
    
    func subscribeToScrollRequests()
}

public extension UIScrollRequestDelegate {
    
    func subscribeToScrollRequests() {
        NotificationCenter.default.addObserver(forName: scrollRequest, object: nil, queue: nil) { [weak self] (notification) in
            
            guard
                let isAddressee = self?.addresseeVerificationFunction(notification),
                isAddressee else { return }
            
            guard
                let data = notification.userInfo,
                let request = data["request"] as? ScrollRequest else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: { [weak self] in
                
                self?.scrollingFunction(request.rect, request.view, request.animated)
            })
        }
    }
}

