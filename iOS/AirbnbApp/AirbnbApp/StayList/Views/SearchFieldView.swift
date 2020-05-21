import UIKit

/// 검색 텍스트 필드에 관한 뷰
class SearchFieldView: UIView, ViewFromXib {
    static let xibName = String(describing: SearchFieldView.self)

    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            drawShadow(searchTextField)
        }
    }

    func configureTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        searchTextField.delegate = delegate
    }

    private func drawShadow(_ subView: UIView) {
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOpacity = 0.6
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 5
        subView.layer.shouldRasterize = true
    }
}

