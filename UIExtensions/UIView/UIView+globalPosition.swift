import UIKit

public extension UIView{
    
    var globalFrameOriginPoint :CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }
    
    var globalCenterPoint :CGPoint? {
        return self.superview?.convert(self.center, to: nil)
    }
    
    var globalFrame :CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
}
