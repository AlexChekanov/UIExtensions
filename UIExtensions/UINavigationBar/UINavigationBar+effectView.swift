import UIKit

public extension UINavigationBar {
    
    var effectView: UIVisualEffectView? {

          return self.subviews
            .filter { NSStringFromClass(type(of: $0)) == "_UIBarBackground" }
            .first?
            .subviews
            .flatMap { $0 as? UIVisualEffectView }
            .first
    }
}
