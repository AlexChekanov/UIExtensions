import UIKit
import GeneralExtensions
import Styles

public extension UILabel {
    
    convenience init(
        text: String,
        style: TextStyle = .normal,
        maximumHeight: CGFloat,
        constantElementsWidth: CGFloat = 0,
        acceptableWidthForTextOfOneLine: CGFloat = 100 //When we don't want the text to be shrinked
        )
    {
        let attributedString = NSMutableAttributedString.init(string: text)
        attributedString.style = style
        
        let boundingSize = attributedString.boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: style.font?.lineHeight ?? 12),
            options: [NSStringDrawingOptions.usesLineFragmentOrigin],
            context: nil).size
        
        let maximalLabelWidth = boundingSize.width
        let minimalLabelHeight = boundingSize.height
        
        let frame_: CGRect = {
            
            var frameToReturn: CGRect = CGRect.zero
            
            if  (maximalLabelWidth < acceptableWidthForTextOfOneLine) || (text.words.count == 1) || maximumHeight < minimalLabelHeight {
                
                frameToReturn = CGRect(origin: CGPoint.zero, size: CGSize(width: maximalLabelWidth+constantElementsWidth, height: minimalLabelHeight))
                
            } else {
                
                let minimalWidth = text.longestWord(style.attributes)?.size(withAttributes: style.attributes).width ?? maximalLabelWidth
                
                // Height calculation
                var flexibleWidth = maximalLabelWidth
                var flexibleHeight: CGFloat = 0.0
                
                var optimalWidth: CGFloat = 0.0
                var optimalHeight: CGFloat = 0.0
                
                var jumpWidths = [CGFloat]()
                var jumpHeights = [CGFloat]()
                
                // Accelerator
                var testWidth = flexibleWidth
                var testHeight: CGFloat = 0.0
                var startWidth: CGFloat = 0.0
                var testWidthShouldBeMultipliedOnNextIteration = false
                
                for _ in 1...6 {
                    
                    testWidth /= 2
                    testWidthShouldBeMultipliedOnNextIteration ? (
                        testWidth *= 3) : ()
                    testHeight = attributedString.boundingRect(
                        with: CGSize(width: testWidth, height: CGFloat.greatestFiniteMagnitude),
                        options: [NSStringDrawingOptions.usesLineFragmentOrigin],
                        context: nil).size.height
                    if testHeight > maximumHeight {
                        testWidthShouldBeMultipliedOnNextIteration = true
                    } else {
                        startWidth = testWidth
                        testWidthShouldBeMultipliedOnNextIteration = false
                    }
                }
                
                if (startWidth > 0.0 && startWidth >= minimalWidth) {flexibleWidth = startWidth}
                
                
                // Main method
                while (flexibleHeight <= maximumHeight && flexibleWidth >= minimalWidth) {
                    
                    if optimalHeight != flexibleHeight {
                        
                        jumpWidths.append(flexibleWidth+1) //fixing line jumps caused previous incremention
                        jumpHeights.append(optimalHeight)
                        
                        optimalHeight = flexibleHeight
                    }
                    
                    optimalHeight = flexibleHeight
                    optimalWidth = flexibleWidth
                    
                    flexibleWidth -= 1
                    
                    flexibleHeight = attributedString.boundingRect(
                        with: CGSize(width: flexibleWidth, height: CGFloat.greatestFiniteMagnitude),
                        options: [NSStringDrawingOptions.usesLineFragmentOrigin],
                        context: nil).size.height
                    
                }
                
                if (jumpWidths.count > 1) && (optimalWidth < acceptableWidthForTextOfOneLine) && (optimalWidth/jumpWidths.last! >= 0.625) {
                    optimalWidth = jumpWidths.last!
                    optimalHeight = jumpHeights.last!
                }
                
                frameToReturn = CGRect(origin: CGPoint.zero, size: CGSize(width: optimalWidth+constantElementsWidth, height: optimalHeight))
            }
            
            return frameToReturn
        }()
        
        self.init(frame: frame_)
        
        self.attributedText = NSAttributedString(string: text, attributes: style.attributes)
        self.adjustsFontSizeToFitWidth = false
        self.numberOfLines = 0
    }
}
