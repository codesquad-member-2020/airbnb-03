import UIKit

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
