import UIKit

final class DateCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: DateCell.self)
    static let reuseIdentifier: String = "DateCell"
    
    @IBOutlet weak var selectedView: CircleView!
    @IBOutlet weak var dayLabel: UILabel!
    
    private func deselected() {
        dayLabel.textColor = .black
        selectedView.isHidden = true
    }
    
    func update(with date: ReservationDate) {
        guard !date.isEmpty
        else {
            dayLabel.text = ""
            return
        }
        
        dayLabel.text = String(date.day)
        dayLabel.textColor = date.isEnabled ? .black : .lightGray
        selectedView.isHidden = !date.isSelected
        
        if date.isSelected {
            dayLabel.textColor = .white
        }
    }
    
    override func prepareForReuse() {
        deselected()
    }
}
