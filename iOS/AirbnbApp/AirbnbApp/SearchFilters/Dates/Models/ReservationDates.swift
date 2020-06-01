import Foundation

struct ReservationDates {
    private var dates: [ReservationDate]
    
    var count: Int {
        return dates.count
    }
    
    var first: ReservationDate? {
        return dates.first
    }
    
    init(dates: [ReservationDate] = []) {
        self.dates = dates
    }
    
    mutating func append(_ reservationDate: ReservationDate) {
        dates.append(reservationDate)
    }
    
    mutating func insert(_ reservationDate: ReservationDate, at index: Int) {
        dates.insert(reservationDate, at: index)
    }
    
    mutating func removeEmptyDates() {
        dates = dates.filter{ !$0.isEmpty }
    }
    
    subscript(index: Int) -> ReservationDate {
        return dates[index]
    }
}
