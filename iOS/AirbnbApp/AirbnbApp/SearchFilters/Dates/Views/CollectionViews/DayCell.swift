import UIKit

final class DayCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: DayCell.self)
    static let reuseIdentifier: String = "DayCell"
    
    @IBOutlet weak var dayLabel: UILabel!
    
    func updateDay(_ day: Int) {
        dayLabel.text = String(day)
    }
    
    func empty() {
        dayLabel.text = ""
    }
}
