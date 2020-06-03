import UIKit

protocol DatesFilterTitleViewDelegate: class {
    func didTapBackButton()
}

final class DatesFilterTitleView: UIView, ViewFromXib {
    
    static var xibName: String = String(describing: DatesFilterTitleView.self)
    static let height: CGFloat = 208.0
    
    weak var delegate: DatesFilterTitleViewDelegate?
    
    override func draw(_ rect: CGRect) {
        drawEdgeLine(edge: .bottom,
                     lineWidth: 0.3,
                     lineColor: .init(white: 0,
                                      alpha: 0.5))
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        delegate?.didTapBackButton()
    }
}
