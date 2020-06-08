class SectionDetailAmenitiesFactory: SectionDetailViewFactory {
    static func makeView(for stayDetail: StayDetail, amenitiesLimit number: Int? = nil) -> SectionDetailAmenities {
        let amenities = AmenityCollection(for: stayDetail)
        return makeView(for: amenities, amenitiesLimit: number)
    }

    static func makeView(for amenities: AmenityCollection, amenitiesLimit number: Int? = nil) -> SectionDetailAmenities {
        let view = SectionDetailAmenities.loadFromXib()

        amenities.limitOrAll(with: number).map {
            let amenityView = AmenityView.loadFromXib()
            amenityView.titleLabel.text = $0.title
            amenityView.symbolImageView.image = $0.symbol

            return amenityView
        }.forEach { view.stackView.addArrangedSubview($0) }

        return view
    }

    static func makeView(for stayDetail: StayDetail) -> ContentView {
        let view = makeView(for: stayDetail, amenitiesLimit: nil)

        return view
    }
}
