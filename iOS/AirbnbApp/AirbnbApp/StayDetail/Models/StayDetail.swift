import Foundation

struct StayDetail: Decodable {
    let id: Int
    let title: String
    let reservable: Bool
    let saved: Bool

    let locationInfo: LocationInfo
    let reviewInfo: reviewInfo

    struct LocationInfo: Decodable {
        let address: String
    }

    struct reviewInfo: Decodable {
        let average: Float
        let numberOfReviews: Int
    }
}
