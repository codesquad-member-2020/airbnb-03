
import UIKit

class CalendarHeaderView: UICollectionReusableView {

    static let nibName: String = String(describing: CalendarHeaderView.self)
    static let reuseIdentifier: String = "CalendarHeaderView"
    static let height: CGFloat = 76.0
    
    @IBOutlet weak var monthAndYearLabel: UILabel!
    
    func update(with date: Date) {
        monthAndYearLabel.text = "\(date.monthName) \(date.year)"
    }
}
