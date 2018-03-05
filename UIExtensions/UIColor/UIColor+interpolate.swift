import UIKit

public extension UIColor {
    
    func interpolate(_ destinationColor: UIColor, at location: CGFloat) -> UIColor {
        
        guard  0...1 ~= location else { return self }
        
        var resultColor: UIColor = .clear
        
        var selfRed:   CGFloat = 0
        var selfGreen: CGFloat = 0
        var selfBlue:  CGFloat = 0
        var selfAlfa:  CGFloat = 0
        
        var destinationRed:   CGFloat = 0
        var destinationGreen: CGFloat = 0
        var destinationBlue:  CGFloat = 0
        var destinationAlfa:  CGFloat = 0
        
        if self.getRed(&selfRed, green: &selfGreen, blue: &selfBlue, alpha: &selfAlfa) &&
            destinationColor.getRed(&destinationRed, green: &destinationGreen, blue: &destinationBlue, alpha: &destinationAlfa) {
            
            let resultRed   = selfRed   + location * (destinationRed   - selfRed)
            let resultGreen = selfGreen + location * (destinationGreen - selfGreen)
            let resultBlue  = selfBlue  + location * (destinationBlue  - selfBlue)
            let resultAlfa  = selfAlfa  + location * (destinationAlfa  - selfAlfa)
            
            resultColor = UIColor(red: resultRed, green: resultGreen, blue: resultBlue, alpha: resultAlfa)
        }
        
        return resultColor
    }
}
