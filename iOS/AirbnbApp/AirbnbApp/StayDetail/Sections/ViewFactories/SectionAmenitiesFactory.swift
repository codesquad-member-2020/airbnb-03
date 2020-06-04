import Foundation

class SectionAmenitiesFactory {
    static func makeView(for stayDetail: StayDetail, amenitiesLimit number: Int) -> SectionAmenities {
        var amenities = AmenityCollection(for: stayDetail)
        return makeView(for: amenities.limited(number))
    }

    static func makeView(for amenities: AmenityCollection) -> SectionAmenities {
        let view = SectionAmenities.loadFromXib()

        amenities.items.map {
            let view = AmenityView.loadFromXib()
            view.titleLabel.text = $0.title
            view.symbolImageView.image = $0.symbol

            return view
        }.forEach { view.stackView.addArrangedSubview($0) }

        return view
    }
}
