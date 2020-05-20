import UIKit

/// Xib에 대응하는 뷰를 불러오기 위한 프로토콜
protocol ViewFromXib: UIView {
    static var xibName: String { get }
}

/// 검색 텍스트 필드에 관한 뷰
class SearchFieldView: UIView, ViewFromXib {
    static let xibName = String(describing: SearchFieldView.self)

    private let searchTextFieldDelegate = SearchTextFieldDelegate()
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = searchTextFieldDelegate
            drawShadow(searchTextField)
        }
    }

    private func drawShadow(_ subView: UIView) {
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOpacity = 0.6
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 5
        subView.layer.shouldRasterize = true
    }
}

class SearchTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
