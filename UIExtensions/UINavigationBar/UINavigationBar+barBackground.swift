import UIKit

public extension UINavigationBar {
    
    var barBackgroundView: UIView? {
        
        return self.subviews
            .filter { NSStringFromClass(type(of: $0)) == "_UIBarBackground" }
            .first
    }
    
    var barBackgroundViewControlled: UIView? {
        
        guard let barBackgroundView = (self.subviews.filter { NSStringFromClass(type(of: $0)) == "_UIBarBackground" }.first) else { return nil }
        
        barBackgroundView.subviews.forEach {

            let copy = $0.copyView()

//            $0.subviews.forEach {
//
//                copy.addSubview($0.copyView())
//
//            }

            barBackgroundView.addSubview(copy)
        }
        
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        shadowImage = UIImage()
        
        return barBackgroundView
    }
}


