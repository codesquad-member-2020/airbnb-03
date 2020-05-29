import Foundation

struct SearchFilterQuery: Encodable {
    var pageOffset: Int
    var checkInDate, checkOutDate: String?
    var adults, children, infants: Int?
    var minPrice, maxPrice: Int?
    var minLatitude, minLongitude, maxLatitude, maxLongitude: Double?

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
    func updateFilters(pageOffset: Int = 1,
                                         date: Date? = nil,
                                         guest: Guest? = nil,
                                         price: Price? = nil,
                                         locationRange: LocationRange? = nil) -> Self {
        SearchFilterQuery(pageOffset: pageOffset,
                          checkInDate: date?.checkIn ?? self.checkInDate,
                          checkOutDate: date?.checkOut ?? self.checkOutDate,
                          adults: guest?.adults ?? self.adults,
                          children: guest?.children ?? self.children,
                          infants: guest?.infants ?? self.infants,
                          minPrice: price?.min ?? self.minPrice,
                          maxPrice: price?.max ?? self.maxPrice,
                          minLatitude: locationRange?.minLatitude ?? self.minLatitude,
                          minLongitude: locationRange?.minLongitude ?? self.minLongitude,
                          maxLatitude: locationRange?.maxLatitude ?? self.maxLatitude,
                          maxLongitude: locationRange?.maxLongitude ?? self.maxLongitude)
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
