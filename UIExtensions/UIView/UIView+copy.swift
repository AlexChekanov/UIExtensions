import UIKit

public extension UIView {
    
    func copyView<T: UIView>() -> T {
        
        let copy = NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
        copy.frame = self.bounds
        
        return copy
    }
}
