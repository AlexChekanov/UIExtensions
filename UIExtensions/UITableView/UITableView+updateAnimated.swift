import UIKit

public extension UITableView {
    
    @objc func update(animated: Bool = false) {
        
        let currentAnimationState = UIView.areAnimationsEnabled
        defer { UIView.setAnimationsEnabled(currentAnimationState) }
        UIView.setAnimationsEnabled(animated)
        
        beginUpdates()
        endUpdates()
    }
}


