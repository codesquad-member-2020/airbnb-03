import Foundation

struct StayDetail: Decodable {
    let id: Int
    let title: String
    let reservable: Bool
    let saved: Bool

    let locationInfo: LocationInfo
    let reviewInfo: ReviewInfo
    let hostInfo: HostInfo
    let roomInfo: RoomInfo
}

extension StayDetail {
    struct LocationInfo: Decodable {
        let address: String
    }

    struct ReviewInfo: Decodable {
        let average: Float
        let numberOfReviews: Int
    }

    struct HostInfo: Decodable {
        let name: String
        let isSuperHost: Bool
        let notes: String
        let about: String
    }

    struct RoomInfo: Decodable {
        let summary: String
        let amenities: String
        let accommodates: Int
        let bathrooms: Int
        let bedrooms: Int
        let beds: Int
    }
}
