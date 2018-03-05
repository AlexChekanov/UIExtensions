import UIKit

public enum ImageFormat {
    case PNG
    case JPEG(CGFloat)
}

public extension UIImage {
    public func encodeBase64(format: ImageFormat) -> String {
        var imageData: NSData
        switch format {
        case .PNG: imageData = UIImagePNGRepresentation(self)! as NSData
        case .JPEG(let compression): imageData = UIImageJPEGRepresentation(self, compression)! as NSData
        }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}

public extension UIImage {
    public func decodeBase64(toImage strEncodeData: String) -> UIImage {
        let imageData: NSData = NSData(base64Encoded: strEncodeData, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        let image = UIImage(data: imageData as Data)
        return image!
    }
}
