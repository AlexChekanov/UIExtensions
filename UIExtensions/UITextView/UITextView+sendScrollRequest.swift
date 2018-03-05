import UIKit

public extension UITextView {
    
    public func sendScrollRequest(animated: Bool, receivers: [UIView]? = nil, identifiers: [String]? = nil ) {
        
        DispatchQueue.main.async {
            
            guard let currentCursorPosition = self.selectedTextRange?.end else { return }
            
            var caret = self.caretRect(for: currentCursorPosition)
            caret.size.height += caret.size.height/2
            // Create some space around
            caret = caret.offsetBy(dx: 0, dy: -caret.size.height/8)
            
            let scrollRequest = ScrollRequest(view: self, rect: caret, animated: false)
            
            var userInfo: [AnyHashable: Any] = [:]
            
            if let receivers = receivers {
                userInfo["receivers"] = receivers
            }
            if let identifiers = identifiers {
                userInfo["identifiers"] = identifiers
            }
            
            userInfo["request"] = scrollRequest
            NotificationCenter.default.post(name: .scrollRequest, object: self, userInfo: userInfo)
        }
    }
}

public extension Notification.Name {
    
    static let scrollRequest = Notification.Name("UIViewScrollRequested")
}

public struct ScrollRequest {
    
    public var view: UIView
    public var rect: CGRect
    public var animated: Bool
}
