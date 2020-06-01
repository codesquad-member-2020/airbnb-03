import UIKit

final class DaysCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var reservationDates: ReservationDates
    
    init(reservationDates: ReservationDates) {
        self.reservationDates = reservationDates
    }
    
    func calculateFirstDayOffset() {
        reservationDates.removeEmptyDates()
        let firstDayDate = reservationDates.first!
        let firstDayOffset = firstDayDate.date.weekday - 1
        for _ in 0..<firstDayOffset {
            var emptyDate = ReservationDate(date: Date())
            emptyDate.setEmpty()
            self.reservationDates.insert(emptyDate, at: 0)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return reservationDates.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DayCell.reuseIdentifier,
            for: indexPath) as! DayCell
        let reservationDate = reservationDates[indexPath.item]
        if reservationDate.isEmpty {
            cell.empty()
            return cell
        } else {
            cell.updateDay(reservationDate.date.day)
        }
        return cell
    }
}
