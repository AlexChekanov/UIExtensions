import UIKit

public extension UIViewController {
    
    func displayError(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Error") , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func displayAlertWithTitle(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .cancel, handler: nil))
        guard let _ = self.presentedViewController else {
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func promptForValue(title: String?, message: String?, placeholder: String?, buttonTitle: String = NSLocalizedString("OK", comment: "OK"), completion: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = placeholder
        }
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { [weak alert] (action) in
            
            guard let textField = alert?.textFields?.first else {
                fatalError("No text fields found in alert")
            }
            
            completion(textField.text)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
