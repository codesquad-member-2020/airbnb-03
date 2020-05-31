import UIKit

final class MonthCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: MonthCell.self)
    static let reuseIdentifier: String = "MonthCell"
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var daysCollectionView: DaysCollectionView!
    
    func updateMonthLabel(monthName: String, year: Int) {
        monthLabel.text = "\(monthName) \(year)"
    }
    
    func updateDays(dayDates: [StayDate]) {
        daysCollectionView.updateDays(dayDates: dayDates)
    }
}
