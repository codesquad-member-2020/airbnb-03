import UIKit

struct AmenityCollection {
    private(set) var items: [Amenity]

    var count: Int {
        items.count
    }

    func limitOrAll(with number: Int?) -> ArraySlice<Amenity> {
        var limit: Int
        if let number = number {
            limit = min(number, self.count)
        } else {
            limit = self.count
        }

        return self.items[0..<limit]
    }
}

extension AmenityCollection {
    init(for stayDetail: StayDetail) {
        let amenitiesText = stayDetail.roomInfo.amenities
        let amenityTitles = amenitiesText.dropFirst().dropLast().split(separator: ",")

        self.items = amenityTitles.map { Amenity(title: String($0), symbol: nil) }
    }
}

typealias AmenityPair = Dictionary<String, UIImage>

extension AmenityCollection {
    static let pairs: AmenityPair = [
        "TV": UIImage(systemName: "tv")!,
        "Internet": UIImage(systemName: "globe")!,
        "Wireless Internet": UIImage(systemName: "wifi")!,
        "First Aid Kit": UIImage(systemName: "bandage")!,
        "Free Parking on Premises": UIImage(systemName: "car")!,
        "Kitchen": UIImage(systemName: "dial.fill")!,
        "Family/Kid Friendly": UIImage(systemName: "person.3.fill")!,
    ]
}
