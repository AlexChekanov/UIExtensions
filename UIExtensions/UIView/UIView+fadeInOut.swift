import UIKit

public extension UIView {
    
    func fadeIn(duration: TimeInterval) {
        
        guard self.alpha != 1 else { return } // || self.isHidden
        
        self.alpha = 0
        self.isHidden = false
        
        UIView.animate(withDuration: duration) { [unowned self] in
            self.alpha = 1
        }
    }
    
    func fadeOut(duration: TimeInterval) {
        
        guard self.alpha == 1 else { return } // || !self.isHidden
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: { success in
             success ? self.isHidden = true : ()
        })
    }
    
    func fadeInResized(duration: TimeInterval) {
        guard self.alpha < 1 else { return }
        
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: duration) { [unowned self] in
            self.transform = CGAffineTransform.identity
            self.alpha = 1
        }
    }
    
    func fadeOutResized(duration: TimeInterval) {
        guard self.alpha > 0 else { return }
        
        UIView.animate(withDuration: duration, animations: { [unowned self] () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.alpha = 0
            }, completion: nil)
    }
}
