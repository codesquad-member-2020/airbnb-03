import Foundation

struct BriefInfo {
    var hostName: String
    var accommodates: Int
    var numberOfBedrooms: Int
    var numberOfBeds: Int
    var numberOfBathrooms: Int
}

extension BriefInfo {
    init(for stayDetail: StayDetail) {
        self.hostName = stayDetail.hostInfo.name
        self.accommodates = stayDetail.roomInfo.accommodates
        self.numberOfBedrooms = stayDetail.roomInfo.bedrooms
        self.numberOfBeds = stayDetail.roomInfo.beds
        self.numberOfBathrooms = stayDetail.roomInfo.bathrooms
    }
}
