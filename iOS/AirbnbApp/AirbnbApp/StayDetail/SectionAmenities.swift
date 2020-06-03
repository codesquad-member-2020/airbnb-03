import UIKit

class SectionAmenities: UIView, ViewFromXib {
    static let xibName = String(describing: SectionAmenities.self)

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewAllButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        let frame = CGRect(x: 0, y: 0, width: stackView.bounds.width, height: 20)
        stackView.resetArrangedSubViews()

        let amenities = [
            Amenity(title: "Internet", symbol: UIImage(systemName: "wifi")),
            Amenity(title: "TV", symbol: UIImage(systemName: "tv")),
            Amenity(title: "Bed", symbol: UIImage(systemName: "bed.double"))
        ]

        amenities.map     { AmenityView(frame: frame, title: $0.title, symbol: $0.symbol) }
                 .forEach { stackView.addArrangedSubview($0) }
    }
}

struct Amenity {
    let title: String
    let symbol: UIImage?
}

extension UIStackView {
    func resetArrangedSubViews() {
        guard arrangedSubviews.count != 0 else { return }

        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
