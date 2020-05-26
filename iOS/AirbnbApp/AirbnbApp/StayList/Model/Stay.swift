import Foundation

struct Stay: Decodable {
    let id: Int
    let images: [String]
    let saved: Bool
    let reviewAverage: Double
    let numberOfReviews: Int
    let hostType: String
    let placeType: String
    let city: String
    let state: String
    let title: String
    let price: Int
    let latitude: Double
    let longitude: Double
}
