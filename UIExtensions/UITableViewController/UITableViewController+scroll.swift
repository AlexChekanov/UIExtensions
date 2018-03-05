import UIKit

public extension UITableViewController {
    
    func scroll(to view: UIView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            var scrollRect = view.frame
            scrollRect = self.tableView.convert(scrollRect, from: view.superview)
            self.tableView.scrollRectToVisible(scrollRect, animated: true)
        }
    }
}

