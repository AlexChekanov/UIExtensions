import UIKit

public extension UIResponder {
    
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
}
// Using this, we can extend UITableViewCell with some convenient read-only computed properties for the table view and index path of the cell.
