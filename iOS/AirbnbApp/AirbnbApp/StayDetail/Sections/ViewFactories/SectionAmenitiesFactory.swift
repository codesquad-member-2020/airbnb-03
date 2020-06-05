import Foundation

class SectionAmenitiesFactory {
    static func makeView(for stayDetail: StayDetail, amenitiesLimit number: Int? = nil) -> SectionAmenities {
        let amenities = AmenityCollection(for: stayDetail)
        return makeView(for: amenities, amenitiesLimit: number)
    }

    static func makeView(for amenities: AmenityCollection, amenitiesLimit number: Int? = nil) -> SectionAmenities {
        let view = SectionAmenities.loadFromXib()
        view.showAllButton.setTitle("Show all \(amenities.count) amenities", for: .normal)

        amenities.limitOrAll(with: number).map {
            let amenityView = AmenityView.loadFromXib()
            amenityView.titleLabel.text = $0.title
            amenityView.symbolImageView.image = $0.symbol

            return amenityView
        }.forEach { view.stackView.addArrangedSubview($0) }

        return view
    }
}
