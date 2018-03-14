import UIKit

public extension UIButton {
    
    func alignImageAndTitleVertically(padding: CGFloat = 8.0) {
        
        let imageSize = self.imageView!.frame.size
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(imageSize.height + padding), 0)
        
        let titleSize = self.titleLabel!.frame.size
        
        self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + padding), 0, 0, -titleSize.width)
        
//        let imageSize = self.imageView!.frame.size
//        let titleSize = self.titleLabel!.frame.size
//        let totalHeight = imageSize.height + titleSize.height + padding
//
//        self.imageEdgeInsets = UIEdgeInsets(
//            top: -(totalHeight - imageSize.height),
//            left: 0,
//            bottom: 0,
//            right: -titleSize.width
//        )
//
//        self.titleEdgeInsets = UIEdgeInsets(
//            top: 0,
//            left: -imageSize.width,
//            bottom: -(totalHeight - titleSize.height),
//            right: 0
//        )
    }
    
}
