import UIKit

public extension UIView {
    
    func addDashedBorder(color: UIColor = UIColor.darkGray, fillColor: UIColor = UIColor.clear, lineWidth: CGFloat = 0.5, dashPattern: [NSNumber] = [6, 3], cornerRadius: CGFloat = 4) {
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.name = "dash"
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        
        self.layer.sublayers?.forEach {
            
            if let sublyer = $0 as? CAShapeLayer, $0.name == "dash" {
                sublyer.removeFromSuperlayer()
            }
        }
        self.layer.addSublayer(shapeLayer)
    }
}
