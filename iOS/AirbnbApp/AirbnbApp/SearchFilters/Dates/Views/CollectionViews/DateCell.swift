import UIKit

final class DateCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: DateCell.self)
    static let reuseIdentifier: String = "DateCell"
    
    @IBOutlet weak var selectedView: CircleView!
    @IBOutlet weak var dayLabel: UILabel!
    
    func updateDay(_ day: Int, isEnabled: Bool) {
        dayLabel.text = String(day)
        dayLabel.textColor = isEnabled ? .black : .lightGray
    }
    
    func empty() {
        dayLabel.text = ""
    }
    
    func selected() {
        dayLabel.textColor = .white
        selectedView.isHidden = false
    }
    
    func deselected() {
        dayLabel.textColor = .black
        selectedView.isHidden = true
    }
    
    override func prepareForReuse() {
        deselected()
    }
}
