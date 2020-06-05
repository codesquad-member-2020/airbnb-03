import UIKit

struct MapInfo {
    let address: String
    let description: String
    let latitude: Double
    let longitude: Double
}

extension MapInfo {
    init(for stayDetail: StayDetail) {
        self.address = stayDetail.locationInfo.address
        self.description = stayDetail.locationInfo.description
        self.latitude = stayDetail.locationInfo.latitude
        self.longitude = stayDetail.locationInfo.longitude
    }
}
