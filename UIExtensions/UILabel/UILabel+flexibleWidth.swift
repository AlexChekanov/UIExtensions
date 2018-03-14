import UIKit
import GeneralExtensions

public extension UILabel {
    
    convenience init(
        text: String,
        font: UIFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body),
        
        maximumHeight: CGFloat,
        
        lineBreakMode: NSLineBreakMode = .byWordWrapping,
        
        constantElementsWidth: CGFloat,
        acceptableWidthForTextOfOneLine: CGFloat, //When we don't want the text to be shrinked
        
        foregroundColor: UIColor = .black,
        backgroundColor: UIColor = .white,
        textAlignment: NSTextAlignment = .natural,
        userInteractionEnabled:Bool?
        )
    {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.allowsDefaultTighteningForTruncation = true
        paragraphStyle.hyphenationFactor = 0
        paragraphStyle.alignment = textAlignment
        
        let attributes: [NSAttributedStringKey:Any] = [
            NSAttributedStringKey.font: font,
            NSAttributedStringKey.foregroundColor: foregroundColor,
            NSAttributedStringKey.backgroundColor: backgroundColor,
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.baselineOffset: 0
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        
        let boundingSize = attributedString.boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: font.lineHeight),
            options: [NSStringDrawingOptions.usesLineFragmentOrigin],
            context: nil).size
        
        let maximalLabelWidth = boundingSize.width
        let minimalLabelHeight = boundingSize.height
        
        let frame_: CGRect = {
            
            var frameToReturn: CGRect = CGRect.zero
            
            if  (maximalLabelWidth < acceptableWidthForTextOfOneLine) || (text.words.count == 1) || maximumHeight < minimalLabelHeight {
                
                frameToReturn = CGRect(origin: CGPoint.zero, size: CGSize(width: maximalLabelWidth+constantElementsWidth, height: minimalLabelHeight))
                
            } else {
                
                let minimalWidth = text.longestWord(attributes)?.size(withAttributes: attributes).width ?? maximalLabelWidth
                
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
                
                if (jumpWidths.count > 1) && (optimalWidth/jumpWidths.last! >= 0.625) {
                    optimalWidth = jumpWidths.last!
                    optimalHeight = jumpHeights.last!
                }
                
                frameToReturn = CGRect(origin: CGPoint.zero, size: CGSize(width: optimalWidth+constantElementsWidth, height: optimalHeight))
            }
            
            return frameToReturn
        }()
        
        self.init(frame: frame_)
        
        self.attributedText = NSAttributedString(string: text, attributes: attributes)
        self.adjustsFontSizeToFitWidth = false
        self.numberOfLines = 0
        self.isUserInteractionEnabled = userInteractionEnabled ?? false
    }
}
