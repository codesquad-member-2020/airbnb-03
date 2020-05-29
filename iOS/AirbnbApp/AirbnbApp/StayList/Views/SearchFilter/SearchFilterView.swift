import UIKit

protocol SearchFilterViewTapDelegate: class {
    func didTapDatesFilter()
}

final class SearchFilterView: UIView, ViewFromXib {
    
    static let xibName = String(describing: SearchFilterView.self)
    static let height: CGFloat = 40
    
    weak var delegate: SearchFilterViewTapDelegate?
    
    @IBAction func didTapDatesFilter(_ sender: Any) {
        delegate?.didTapDatesFilter()
    }
}
