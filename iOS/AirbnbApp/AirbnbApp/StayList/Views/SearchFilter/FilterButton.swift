import UIKit

final class FilterButton: UIButton {
    
    private let sidePadding: CGFloat = 20
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        drawBorder()
    }

    private func drawBorder() {
        layer.cornerRadius = self.bounds.height / 2
        layer.borderWidth =  1
        layer.borderColor = UIColor.lightGray.cgColor
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + (sidePadding * 2), height: size.height)
    }
    
    func update(with filtered: Bool, guests: (adults: Int, children: Int, infants: Int)? = nil) {
        guard let guests = guests else { return }
        if filtered {
            var guestsText = "Guests \(guests.adults + guests.children)"
            if guests.infants != 0 {
                guestsText = "\(guestsText) ・ infants \(guests.infants)"
            }
            setTitle(guestsText, for: .normal)
        }
        backgroundColor = filtered ? .darkGray : .white
        setTitleColor(filtered ? .white : .darkGray, for: .normal)
    }
    
    func update(with dates: (checkIn: String?, checkOut: String?)) {
        guard let checkIn = dates.checkIn else { return }
        guard let checkOut = dates.checkOut else { return }
        let checkInDate = DateFormatter.reservation.date(from: checkIn)!
        let checkOutDate = DateFormatter.reservation.date(from: checkOut)!
        
        if checkInDate.monthName == checkOutDate.monthName {
            setTitle(
                "\(checkInDate.monthName) \(checkInDate.day) - \(checkOutDate.day)",
                for: .normal)
        } else {
            setTitle(
                "\(checkInDate.monthName) \(checkInDate.day) - \(checkOutDate.monthName) \(checkOutDate.day)",
                for: .normal)
        }
        
        backgroundColor = .darkGray
        setTitleColor(.white, for: .normal)
    }
}
