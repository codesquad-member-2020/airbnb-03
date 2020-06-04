import Foundation

struct TitleInfo {
    let reviewAverage: Float
    let numberOfReviews: Int
    let address: String
}

extension TitleInfo {
    init(for stayDetail: StayDetail) {
        self.reviewAverage = stayDetail.reviewInfo.average
        self.numberOfReviews = stayDetail.reviewInfo.numberOfReviews
        self.address = stayDetail.locationInfo.address
    }
}
