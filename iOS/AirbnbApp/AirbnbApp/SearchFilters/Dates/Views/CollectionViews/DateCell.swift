import UIKit

final class DateCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: DateCell.self)
    static let reuseIdentifier: String = "DateCell"
    
    @IBOutlet weak var betweenSelectionsView: UIView!
    @IBOutlet weak var checkInSelectedView: UIView!
    @IBOutlet weak var checkOutSelectedView: UIView!
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
    
    func updateCheckInOutCell(isCheckIn: Bool) {
        if isCheckIn {
            checkInSelectedView.isHidden = false
        } else {
            checkOutSelectedView.isHidden = false
        }
    }
    
    func updateBetweenCells(with date: ReservationDate) {
        guard !date.isEmpty
        else {
            return
        }
        if date.date.weekday == 1 {
            betweenSelectionsView.round(corners: [.topLeft, .bottomLeft], radius: 6.0)
        } else if date.date.weekday == 7 {
            betweenSelectionsView.round(corners: [.topRight, .bottomRight], radius: 6.0)
        }
        betweenSelectionsView.isHidden = false
    }
    
    override func prepareForReuse() {
        deselected()
        betweenSelectionsView.isHidden = true
        checkInSelectedView.isHidden = true
        checkOutSelectedView.isHidden = true
        betweenSelectionsView.round(
            corners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
            radius: 0.0)
    }
}
