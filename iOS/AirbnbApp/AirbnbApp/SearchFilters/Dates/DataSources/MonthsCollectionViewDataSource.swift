import UIKit

class MonthsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var totalReservationDates: [ReservationDates]
    private var daysCollectionViewDataSources: [DaysCollectionViewDataSource]
    
    init(totalReservationDates: [ReservationDates]) {
        self.totalReservationDates = totalReservationDates
        daysCollectionViewDataSources = totalReservationDates.map {
            DaysCollectionViewDataSource(reservationDates: $0)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return totalReservationDates.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MonthCell.reuseIdentifier,
            for: indexPath) as! MonthCell
        let firstDayOfMonth = totalReservationDates[indexPath.item].first!
        cell.updateMonthLabel(
            monthName: firstDayOfMonth.date.monthName,
            year: firstDayOfMonth.year)
        let dataSource = daysCollectionViewDataSources[indexPath.item]
        cell.configureDaysCollectionViewDataSource(dataSource)
        return cell
    }
}
