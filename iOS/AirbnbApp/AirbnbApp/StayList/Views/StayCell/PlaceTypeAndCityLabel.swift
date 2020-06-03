import UIKit

final class PlaceTypeAndCityLabel: UILabel {

    func updateWith(type: String, city: String) {
        text = "\(type) ・ \(city)"
    }
}
