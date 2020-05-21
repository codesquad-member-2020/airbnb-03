import UIKit

class SearchFieldView: UIView, ViewFromXib {
    static let xibName = String(describing: SearchFieldView.self)

    @IBOutlet weak var searchTextField: SearchTextField!

    func configureTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        searchTextField.delegate = delegate
    }
}

