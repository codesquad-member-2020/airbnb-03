import Foundation

struct SearchFilterQuery: Encodable {
    private var pageOffset: Int = 1
    private(set) var checkInDate: String? = nil
    private(set) var checkOutDate: String? = nil
    private(set) var adults: Int? = nil
    private(set) var children: Int? = nil
    private(set) var infants: Int? = nil
    private(set) var minPrice: Int? = nil
    private(set) var maxPrice: Int? = nil
    private(set) var minLatitude: Double? = nil
    private(set) var minLongitude: Double? = nil
    private(set) var maxLatitude: Double? = nil
    private(set) var maxLongitude: Double? = nil
    
    struct Date {
        let checkIn, checkOut: String?
    }
    
    struct Guest {
        let adults, children, infants: Int?
    }
    
    struct Price {
        let min, max: Int?
    }
    
    struct LocationRange {
        let minLatitude, minLongitude, maxLatitude, maxLongitude: Double?
    }
}

// MARK:- Update Filters Method

extension SearchFilterQuery {
    mutating func updateFilters(
        pageOffset: Int = 1,
        date: Date? = nil,
        guest: Guest? = nil,
        price: Price? = nil,
        locationRange: LocationRange? = nil) {
        self.pageOffset = pageOffset
        checkInDate = date?.checkIn ?? self.checkInDate
        checkOutDate = date?.checkOut ?? self.checkOutDate
        adults = guest?.adults ?? self.adults
        children = guest?.children ?? self.children
        infants = guest?.infants ?? self.infants
        minPrice = price?.min ?? self.minPrice
        maxPrice = price?.max ?? self.maxPrice
        minLatitude = locationRange?.minLatitude ?? self.minLatitude
        minLongitude = locationRange?.minLongitude ?? self.minLongitude
        maxLatitude = locationRange?.maxLatitude ?? self.maxLatitude
        maxLongitude = locationRange?.maxLongitude ?? self.maxLongitude
    }
}

// MARK:- CodingKeys

extension SearchFilterQuery {
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
}
