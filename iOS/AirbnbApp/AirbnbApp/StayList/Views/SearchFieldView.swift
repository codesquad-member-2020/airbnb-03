import UIKit

protocol ViewFromXib: UIView {
    static var xibName: String { get }
}

// TODO: Return키 델리게이트, 그림자 효과
class SearchFieldView: UIView, ViewFromXib {
    static let xibName = String(describing: SearchFieldView.self)

    @IBOutlet weak var searchTextField: UITextField! {
        didSet { drawShadow(searchTextField) }
    }

    private func drawShadow(_ subView: UIView) {
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOpacity = 0.6
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 5
        subView.layer.shouldRasterize = true
    }
}
