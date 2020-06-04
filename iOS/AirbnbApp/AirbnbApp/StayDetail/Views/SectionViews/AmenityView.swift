import UIKit

class AmenityView: UIView, ViewFromXib {
    static var xibName: String = .init(describing: AmenityView.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var symbolImageView: UIImageView!
}

struct Amenity {
    let title: String
    let symbol: UIImage?

    init(title: String, symbol: UIImage?) {
        self.title = title
        if let symbol = symbol {
            self.symbol = symbol
        } else {
            self.symbol = AmenityCollection.pairs[title]
        }
    }
}

class AmenityViewFactory {
    static func makeView(for amenity: Amenity) -> AmenityView {
        let view = AmenityView.loadFromXib()

        view.titleLabel.text = amenity.title
        view.symbolImageView.image = amenity.symbol

        return view
    }
}
