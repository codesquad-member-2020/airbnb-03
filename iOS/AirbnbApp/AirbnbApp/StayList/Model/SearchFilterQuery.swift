import Foundation

struct SearchFilterQuery: Encodable {
    let pageOffset: Int
    let checkInDate: String?
    let checkOutDate: String?
    let adults, children, infants: Int?
    let minPrice: Int?
    let maxPrice: Int?
    let minLatitude: Double?
    let minLongitude: Double?
    let maxLatitude: Double?
    let maxLongitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case pageOffset = "offset"
        case checkInDate = "check_in"
        case checkOutDate = "check_out"
        case adults, children, infants
        case minPrice = "min_price"
        case maxPrice = "max_price"
        case minLatitude = "min_lat"
        case maxLatitude = "max_lat"
        case minLongitude = "min_long"
        case maxLongitude = "max_long"
    }

    init(pageOffset: Int = 1,
         checkInDate: String? = nil,
         checkOutDate: String? = nil,
         adults: Int? = nil,
         children: Int? = nil,
         infants: Int? = nil,
         minPrice: Int? = nil,
         maxPrice: Int? = nil,
         minLatitude: Double? = nil,
         minLongitude: Double? = nil,
         maxLatitude: Double? = nil,
         maxLongitude: Double? = nil) {
        self.pageOffset = pageOffset
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.adults = adults
        self.children = children
        self.infants = infants
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.minLatitude = minLatitude
        self.minLongitude = minLongitude
        self.maxLatitude = maxLatitude
        self.maxLongitude = maxLongitude
    }
}
