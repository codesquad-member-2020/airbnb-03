import UIKit

protocol DatesFilterFixedFooterViewDelegate: class {
    func didTapSearchButton(date: (checkIn: String, checkOut: String)?)
}

final class DatesFilterFixedFooterView: UIView, ViewFromXib {
    
    static var xibName: String = String(describing: DatesFilterFixedFooterView.self)
    static let height: CGFloat = 96
    
    weak var delegate: DatesFilterFixedFooterViewDelegate?
    private var date: (String, String)?
    
    override func draw(_ rect: CGRect) {
        drawEdgeLine(edge: .top, lineWidth: 0.3, lineColor: .lightGray)
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
        delegate?.didTapSearchButton(date: date)
    }
}
