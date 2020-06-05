import UIKit

protocol SearchTextFieldSearchDelegate: class {
    func searchStayList(keyword: String?)
}

final class SearchTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    weak var searchDelegate: SearchTextFieldSearchDelegate?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchDelegate?.searchStayList(keyword: textField.text)
        textField.resignFirstResponder()

        return true
    }
}
