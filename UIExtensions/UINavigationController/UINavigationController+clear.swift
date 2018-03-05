import UIKit

public extension UINavigationController {
    
    // Make the status bar fully transparent
    func makeClear() {
        
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        
        self.navigationController?.view.backgroundColor = .clear
        
    }
}
