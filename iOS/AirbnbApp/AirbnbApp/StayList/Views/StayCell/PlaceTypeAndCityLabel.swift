import UIKit

class PlaceTypeAndCityLabel: UILabel {

    func updateWith(type: String, city: String) {
        text = "\(type) ・ \(city)"
    }
}
