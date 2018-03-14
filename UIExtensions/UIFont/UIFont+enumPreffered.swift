import UIKit

public extension UIFont {
    
    enum Prebuilt: Int {
        case LargeTitle = 0, Title1, Title2, Title3, Headline, Body, Callout, Subhead, Footnote, Caption1, Caption2
        
        var font: UIFont {
            switch self {
            case .LargeTitle:
                if #available(iOS 11.0, *) {
                    return UIFont.preferredFont(forTextStyle: UIFontTextStyle.largeTitle)
                } else {
                    return UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
                }
            case .Title1:
                return UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
            case .Title2:
                return UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)
            case .Title3:
                return UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3)
            case .Headline:
                return UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
            case .Body:
                return UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
            case .Callout:
                return UIFont.preferredFont(forTextStyle: UIFontTextStyle.callout)
            case .Subhead:
                return UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
            case .Footnote:
                return UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)
            case .Caption1:
                return UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
            case .Caption2:
                return UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption2)
            }
        }
        
        public static func getFont(rawValue: Int) -> UIFont  {
            if let fontType = Prebuilt(rawValue: rawValue) {
                return fontType.font
            }
            return Prebuilt.Body.font
        }
    }
}
