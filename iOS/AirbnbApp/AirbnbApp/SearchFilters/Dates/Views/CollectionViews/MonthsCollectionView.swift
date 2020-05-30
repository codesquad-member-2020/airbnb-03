import UIKit

final class MonthsCollectionView: UICollectionView {
    
    private var currentDate: StayDate = StayDate(date: Date())
    private var checkInDate: StayDate? = nil
    private var checkOutDate: StayDate? = nil
    private var dayStayDates: [[StayDate]] = []
    
    private let spacingForItem: CGFloat = 16.0
    private let numberOfDaysInMonth: [Int] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    override init(frame: CGRect,
                  collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame,
                   collectionViewLayout: UICollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureCell()
        configureUI()
        configureCollectionView()
        configureDatesData()
    }
    
    private func configureDatesData() {
        for offset in 0..<12 {
            let monthUpdatedDate = currentDate.after(month: offset)
            var dayDatesByMonth = [StayDate]()
            for day in 1...numberOfDaysInMonth[monthUpdatedDate.month] {
                dayDatesByMonth.append(StayDate(year: monthUpdatedDate.year,
                                                month: monthUpdatedDate.month,
                                                day: day))
            }
            dayStayDates.append(dayDatesByMonth)
        }
    }
    
    private func configureCell() {
        let nib = UINib(nibName: MonthCell.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: MonthCell.reuseIdentifier)
    }
    
    private func configureCollectionView() {
        delegate = self
        dataSource = self
    }
    
    private func configureUI() {
        backgroundColor = .white
    }
}

extension MonthsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        #warning("dynamic cell size")
        return .init(width: collectionView.bounds.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingForItem
    }
}

extension MonthsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return dayStayDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCell.reuseIdentifier,
                                                      for: indexPath) as! MonthCell

        let firstDayOfMonth = dayStayDates[indexPath.item].first!
        let dayDates = dayStayDates[indexPath.item]
        cell.updateMonthLabel(monthName: firstDayOfMonth.date.monthName,
                              year: firstDayOfMonth.year)
        cell.updateDays(dayDates: dayDates)
        return cell
    }
}
