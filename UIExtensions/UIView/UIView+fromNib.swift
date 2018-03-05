import UIKit

public extension UIView {
    
    @discardableResult   // Using a discardable return value since the returned view is mostly of no interest to caller when all outlets are already connected.
    
    public func loadFromNib<T : UIView>() -> T? {   // This is a generic method that returns an optional object of type UIView. If it fails to load the view, it returns nil.
        
        // Attempting to load a XIB file with the same name as the current class instance. If that fails, nil is returned.
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        self.addSubview(contentView)     // Adding the top level view to the view hierarchy.
        
        contentView.translatesAutoresizingMaskIntoConstraints = false   // This line assumes we're using constraints to layout the view.
        contentView.layoutAttachAll()   // This method adds top, bottom, leading & trailing constraints - attaching the view to "self" on all sides (See: https://stackoverflow.com/a/46279424/2274829 for details)
        return contentView   // Returning the top level view
    }
}

/*
 
 And the caller method might look like this:
 
 final class SomeView: UIView {   // 1.
 required init(coder aDecoder: NSCoder) {   // 2 - storyboard initializer
 super.init(coder: aDecoder)
 fromNib()   // 5.
 }
 init() {   // 3 - programmatic initializer
 super.init(frame: CGRect.zero)  // 4.
 fromNib()  // 6.
 }
 // other methods ...
 
 }
 */

