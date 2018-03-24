import UIKit

public extension UIView {
    
    func show(animated: Bool = true, duration: TimeInterval = 0.2, resizing: Bool = false, completion: @escaping ()->() = {}) {
        
        guard animated else { self.alpha = 1; completion(); return }
        
        alpha = 0
        resizing ? self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1) : ()
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            resizing ? self?.transform = CGAffineTransform.identity : ()
            self?.alpha = 1
        }) { success in
            success ? completion() : ()
        }
    }
    
    func hide(animated: Bool = true, duration: TimeInterval = 0.2, resizing: Bool = false, completion: @escaping ()->() = {}) {
        
        guard animated else { self.alpha = 0; completion(); return }
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            resizing ? self?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1) : ()
            self?.alpha = 0
        }) { success in
            success ? completion() : ()
        }
    }
    
    func blink(animated: Bool = true, duration: TimeInterval = 0.4, resizing: Bool = false) {
        
        hide(animated: animated, duration: duration/2, resizing: resizing) { [weak self] in
            self?.show(animated: animated, duration: duration/2, resizing: resizing)
        }
    }
}
