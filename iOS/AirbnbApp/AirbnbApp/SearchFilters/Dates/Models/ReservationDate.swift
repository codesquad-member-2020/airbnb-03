import Foundation

struct ReservationDate {
    private(set) var year: Int
    private(set) var month: Int
    private(set) var day: Int
    private(set) var isEmpty: Bool = false
    private(set) var isEnabled: Bool = true
    private(set) var isSelected: Bool = false
    
    init(year: Int,
         month: Int,
         day: Int = 1) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    init(date: Date) {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = calendar.dateComponents([.year, .month, .day],
                                                 from: date)
        year = components.year ?? 0
        month = components.month ?? 0
        day = components.day ?? 0
    }
    
    var date: Date {
        let dateString = "\(year)-\(month)-\(day)"
        return DateFormatter.reservation.date(from: dateString)!
    }
    
    var string: String {
        return "\(year)-\(month)-\(day)"
    }
    
    /// '월'을 더하여 ReservationDate를 반환하는 메소드
    /// - Parameter monthOffset: 더하고 싶은 월의 값
    func after(monthOffset: Int) -> Self {
        var year = self.year
        var month = self.month + monthOffset
        if month > 12 {
            year += 1
            month -= 12
        }
        return ReservationDate(year: year, month: month)
    }
    
    @discardableResult mutating func selected() -> ReservationDate {
        isSelected = true
        return self
    }
    
    @discardableResult mutating func deselected() -> ReservationDate {
        isSelected = false
        return self
    }
    
    mutating func disabled() {
        isEnabled = false
    }
    
    mutating func setEmpty() {
        isEmpty = true
        isEnabled = false
    }
}

extension ReservationDate: Comparable {
    static func < (lhs: ReservationDate, rhs: ReservationDate) -> Bool {
        return lhs.date < rhs.date
    }
    
    static func == (lhs: ReservationDate, rhs: ReservationDate) -> Bool {
        return lhs.date == rhs.date
    }
}

extension DateFormatter {
    static let reservation: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)!
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
}
