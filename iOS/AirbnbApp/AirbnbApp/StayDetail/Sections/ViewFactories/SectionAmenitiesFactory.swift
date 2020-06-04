import Foundation

class SectionAmenitiesFactory {
    static func makeView(for stayDetail: StayDetail, amenitiesLimit number: Int) -> SectionAmenities {
        let amenities = AmenityCollection(for: stayDetail)
        return makeView(for: amenities, amenitiesLimit: number)
    }

    static func makeView(for amenities: AmenityCollection, amenitiesLimit number: Int) -> SectionAmenities {
        let view = SectionAmenities.loadFromXib()
        view.viewAllButton.setTitle("Show all \(amenities.count) amenities", for: .normal)

        let limit = min(number, amenities.count)
        amenities.items[0..<limit].map {
            let amenityView = AmenityView.loadFromXib()
            amenityView.titleLabel.text = $0.title
            amenityView.symbolImageView.image = $0.symbol

            return amenityView
        }.forEach { view.stackView.addArrangedSubview($0) }

        return view
    }
}
