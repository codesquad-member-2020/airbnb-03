import Foundation

struct StayDate {
    private(set) var year: Int
    private(set) var month: Int
    private(set) var day: Int
    
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
    
    func after(month offset: Int) -> Self {
        var year = self.year
        var month = self.month + offset
        if month > 12 {
            year += 1
            month -= 12
        }
        return StayDate(year: year, month: month)
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
