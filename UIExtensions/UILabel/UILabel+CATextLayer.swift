import Foundation
import UIKit

public extension UILabel {
    
    func convertToCATextLayer() -> CATextLayer {
        
        let textLayer = CATextLayer()
        textLayer.frame = self.frame
        
        textLayer.rasterizationScale = UIScreen.main.scale
        textLayer.contentsScale = UIScreen.main.scale
        
        switch self.textAlignment {
            
        case .left:
            textLayer.alignmentMode = kCAAlignmentLeft
        case .center:
            textLayer.alignmentMode = kCAAlignmentCenter
        case .right:
            textLayer.alignmentMode = kCAAlignmentRight
        case .justified:
            textLayer.alignmentMode = kCAAlignmentJustified
        case .natural:
            textLayer.alignmentMode = kCAAlignmentNatural
        }
        
        switch self.lineBreakMode {
            
        case .byWordWrapping:
            textLayer.isWrapped = true
        case .byCharWrapping:
            textLayer.isWrapped = true
            textLayer.truncationMode = kCATruncationNone
        case .byClipping:
            textLayer.isWrapped = false
            textLayer.truncationMode = kCATruncationNone
        case .byTruncatingHead:
            textLayer.truncationMode = kCATruncationStart
        case .byTruncatingTail:
            textLayer.truncationMode = kCATruncationEnd
        case .byTruncatingMiddle:
            textLayer.truncationMode = kCATruncationMiddle
        }
        
        textLayer.fontSize = self.font.pointSize
        textLayer.font = self.font
        textLayer.string = self.text
        
        return textLayer
    }
}
