import UIKit

final class CalendarCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var totalReservationDates: [ReservationDates]
    
    init(totalReservationDates: [ReservationDates]) {
        self.totalReservationDates = totalReservationDates
    }
    
    func update(with totalReservationDates: [ReservationDates]) {
        self.totalReservationDates = totalReservationDates
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        totalReservationDates.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        let reservationDatesByMonth = totalReservationDates[section]
        return reservationDatesByMonth.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DateCell.reuseIdentifier,
            for: indexPath) as! DateCell
        let date = totalReservationDates[indexPath.section][indexPath.item]
        cell.update(with: date)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader
        else {
            assert(false)
        }
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CalendarHeaderView.reuseIdentifier,
            for: indexPath) as! CalendarHeaderView
        let reservationDatesByMonth = totalReservationDates[indexPath.section]
        let lastDayDate = reservationDatesByMonth.last!.date
        headerView.update(with: lastDayDate)
        return headerView
    }
}
