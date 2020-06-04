import UIKit

class SectionAmenities: UIView, ContentView, ViewFromXib {
    static let xibName = String(describing: SectionAmenities.self)

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewAllButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        stackView.resetArrangedSubViews()
    }

    func updateChanges() {

    }
}

struct AmenityCollection {
    private(set) var items: [Amenity]

    mutating func limited(_ limit: Int) -> Self {
        items = Array<Amenity>(items[0..<limit])

        return self
    }
}

extension AmenityCollection {
    init(for stayDetail: StayDetail) {
        let amenitiesText = stayDetail.roomInfo.amenities
        let amenityTitles = amenitiesText.dropFirst().dropLast().split(separator: ",")

        self.items = amenityTitles.map { Amenity(title: String($0), symbol: nil) }
    }
}

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
