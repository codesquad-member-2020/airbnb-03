import Foundation

struct ReservationDates {
    private var dates: [ReservationDate]
    
    var count: Int {
        return dates.count
    }
    
    var last: ReservationDate? {
        return dates.last
    }
    
    init(dates: [ReservationDate] = []) {
        self.dates = dates
    }
    
    mutating func configureFirstDayOffsetDates() {
        removeEmptyDates()
        let firstDayDate = dates.first!
        let firstDayOffset = firstDayDate.date.weekday - 1
        for _ in 0..<firstDayOffset {
            var emptyDate = ReservationDate(date: Date())
            emptyDate.setEmpty()
            self.dates.insert(emptyDate, at: 0)
        }
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
        get {
            dates[index]
        }
        set(newValue) {
            dates[index] = newValue
        }
    }
}
