import Foundation

class AmenityViewFactory {
    static func makeView(for amenity: Amenity) -> AmenityView {
        let view = AmenityView.loadFromXib()

        view.titleLabel.text = amenity.title
        view.symbolImageView.image = amenity.symbol

        return view
    }
}
