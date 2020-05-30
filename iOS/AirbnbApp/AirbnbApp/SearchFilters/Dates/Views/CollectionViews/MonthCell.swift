import UIKit

final class MonthCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: MonthCell.self)
    static let reuseIdentifier: String = "MonthCell"

    @IBOutlet weak var monthLabel: UILabel!
    
    func updateMonthLabel(with month: Int,
                          year: Int) {
        monthLabel.text = "\(month)월 \(year)"
    }
}
