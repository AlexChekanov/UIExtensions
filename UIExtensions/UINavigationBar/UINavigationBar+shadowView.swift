import UIKit

public extension UINavigationBar {
    
    var shadowView: UIImageView? {
        
        return self.subviews
            .filter { NSStringFromClass(type(of: $0)) == "_UIBarBackground" }
            .first?
            .subviews
            .flatMap { $0 as? UIImageView }
            .first
    }
}
