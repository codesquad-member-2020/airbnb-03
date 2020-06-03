import UIKit

protocol DatesFilterViewControllerSearchDelegate: class {
    func searchStayList(dates: (checkIn: String?, checkOut: String?))
}

final class DatesFilterViewController: SearchFooterViewController {
    
    private var titleView: DatesFilterTitleView!
    
    private var calendarCollectionView: CalendarCollectionView!
    private var calendarCollectionViewDataSource: CalendarCollectionViewDataSource!
    weak var searchDelegate: DatesFilterViewControllerSearchDelegate?
    
    private let spacingForItemLine: CGFloat = 0.0
    private let numberOfDaysAt: [Int] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    private var totalReservationDates: [ReservationDates] = []
    private var historyOfSelectedIndexPath: [IndexPath] = [] {
        didSet {
            calendarCollectionViewDataSource.update(with: historyOfSelectedIndexPath)
        }
    }
    
    private var checkInDate: ReservationDate? = nil {
        didSet {
            searchFooterView.updateClearButton(with: checkInDate != nil)
        }
    }
    
    private var checkOutDate: ReservationDate? = nil {
        didSet {
            searchFooterView.updateSearchButton(with: checkOutDate != nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureDelegates()
        configureCollectionView()
        configureLayout()
    }
}

extension DatesFilterViewController {
    private func configureCollectionView() {
        configureDatesData()
        calendarCollectionViewDataSource = CalendarCollectionViewDataSource(
            totalReservationDates: totalReservationDates)
        calendarCollectionView.dataSource = calendarCollectionViewDataSource
        calendarCollectionView.delegate = self
    }
    
    private func configureDatesData() {
        for monthOffset in 0..<12 {
            let currentDate = ReservationDate(date: Date())
            let monthUpdatedDate = currentDate.after(monthOffset: monthOffset)
            var datesByMonth = ReservationDates()
            for day in 1...numberOfDaysAt[monthUpdatedDate.month] {
                var dayDate = ReservationDate(
                    year: monthUpdatedDate.year,
                    month: monthUpdatedDate.month,
                    day: day)
                if dayDate <= currentDate {
                    dayDate.disabled()
                }
                datesByMonth.append(dayDate)
            }
            datesByMonth.configureFirstDayOffsetDates()
            totalReservationDates.append(datesByMonth)
        }
    }
}

// MARK:- Delegations Configuration

extension DatesFilterViewController {
    private func configureDelegates() {
        titleView.delegate = self
        searchFooterView.delegate = self
    }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension DatesFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingForItemLine
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 7.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: CalendarHeaderView.height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
        let datesByMonth = totalReservationDates[indexPath.section]
        let selectedDate = datesByMonth[indexPath.item]
        
        guard selectedDate.isEnabled
        else {
            return
        }
        
        if checkInDate != nil, checkOutDate != nil {
            resetSelectedDates()
            self.checkInDate = selectedDate
        } else if let checkInDate = checkInDate, checkOutDate == nil {
            guard selectedDate != checkInDate
            else {
                return
            }
            if selectedDate > checkInDate {
                checkOutDate = selectedDate
                #warning("Update cells between check-in and check-out dates")
            } else {
                resetSelectedDates()
                self.checkInDate = selectedDate
            }
        } else if checkInDate == nil, checkOutDate == nil {
            checkInDate = selectedDate
        }
        
        historyOfSelectedIndexPath.append(indexPath)
        updateSelectedDateToTotalReservationDates(at: indexPath)
        updateCalendarCollectionViewDataSource()
    }
    
    private func updateSelectedDateToTotalReservationDates(at indexPath: IndexPath) {
        totalReservationDates[indexPath.section][indexPath.item].selected()
    }
    
    private func updateCalendarCollectionViewDataSource() {
        calendarCollectionViewDataSource.update(with: totalReservationDates)
        calendarCollectionView.reloadData()
    }
    
    private func resetSelectedDates() {
        historyOfSelectedIndexPath.forEach {
            totalReservationDates[$0.section][$0.item].deselected()
        }

        historyOfSelectedIndexPath.removeAll()
        updateCalendarCollectionViewDataSource()
        
        checkInDate = nil
        checkOutDate = nil
    }
}

// MARK:- DatesFilterTitleViewDelegate

extension DatesFilterViewController: DatesFilterTitleViewDelegate {
    func didTapBackButton() {
        dismiss(animated: true)
    }
}

// MARK:- SearchFooterViewDelegate

extension DatesFilterViewController: SearchFooterViewDelegate {
    func didTapSearchButton() {
        let selectedDates = (checkInDate?.string, checkOutDate?.string)
        self.searchDelegate?.searchStayList(dates: selectedDates)
        dismiss(animated: true)
    }
    
    func didTapClearButton() {
        resetSelectedDates()
    }
}

// MARK:- UI & Layout

extension DatesFilterViewController {
    private func configureUI() {
        view.backgroundColor = .white
        titleView = DatesFilterTitleView.loadFromXib()
        calendarCollectionView = CalendarCollectionView()
    }
    
    private func configureLayout() {
        view.addSubviews(
            titleView,
            calendarCollectionView)
        titleView.constraints(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: nil,
            trailingAnchor: view.trailingAnchor,
            size: CGSize(width: 0, height: DatesFilterTitleView.height))
        calendarCollectionView.constraints(
            topAnchor: titleView.bottomAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: searchFooterView.topAnchor,
            trailingAnchor: view.trailingAnchor,
            padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
}
