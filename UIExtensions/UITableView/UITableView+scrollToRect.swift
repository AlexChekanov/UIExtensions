import UIKit

public extension UITableView {
    
    func scrollTo(_ rect: CGRect, in view: UIView, animated: Bool) {
        
        let rectToScroll = view.convert(rect, to: self)
        scrollRectToVisible(rectToScroll, animated: animated)
    }
}
