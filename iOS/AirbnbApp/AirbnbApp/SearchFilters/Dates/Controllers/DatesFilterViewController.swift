import UIKit

protocol DatesFilterViewControllerSearchDelegate: class {
    func searchStayList(date: (checkIn: String, checkOut: String)?)
}

final class DatesFilterViewController: UIViewController {
    
    private var titleView: DatesFilterTitleView!
    private var fixedFooterView: DatesFilterFixedFooterView!
    
    private var calendarCollectionView: CalendarCollectionView!
    private var calendarCollectionViewDataSource: CalendarCollectionViewDataSource!
    weak var searchDelegate: DatesFilterViewControllerSearchDelegate?
    
    private let spacingForItemLine: CGFloat = 2.0
    private let numberOfDaysAt: [Int] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    private var historyOfSelectedCell: [DateCell] = []
    private var checkInDate: ReservationDate? = nil
    private var checkOutDate: ReservationDate? = nil
    private var totalReservationDates: [ReservationDates] = []

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
                datesByMonth.append(
                    ReservationDate(
                        year: monthUpdatedDate.year,
                        month: monthUpdatedDate.month,
                        day: day))
            }
            datesByMonth.configureFirstDayOffsetDates()
            totalReservationDates.append(datesByMonth)
        }
    }
}

// MARK:- Delegations Configuration

extension DatesFilterViewController {
    private func configureDelegates() {
        fixedFooterView.delegate = self
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
        let selectedCell = calendarCollectionView.cellForItem(at: indexPath) as! DateCell
        if checkInDate != nil, checkOutDate != nil {
            historyOfSelectedCell.forEach {
                $0.deselected()
            }
            historyOfSelectedCell.removeAll()
            checkOutDate = nil
            historyOfSelectedCell.append(selectedCell)
            self.checkInDate = selectedDate
            selectedCell.selected()
        } else if let checkInDate = checkInDate, checkOutDate == nil {
            guard selectedDate != checkInDate
            else {
                return
            }
            if selectedDate > checkInDate {
                historyOfSelectedCell.append(selectedCell)
                checkOutDate = selectedDate
                #warning("Update cells between check-in and check-out dates")
                selectedCell.selected()
            } else {
                historyOfSelectedCell.forEach {
                    $0.deselected()
                }
                historyOfSelectedCell.removeAll()
                checkOutDate = nil
                historyOfSelectedCell.append(selectedCell)
                self.checkInDate = selectedDate
                selectedCell.selected()
            }
        } else if checkInDate == nil, checkOutDate == nil {
            historyOfSelectedCell.append(selectedCell)
            checkInDate = selectedDate
            selectedCell.selected()
        }
    }
}

// MARK:- DatesFilterFixedFooterViewDelegate

extension DatesFilterViewController: DatesFilterFixedFooterViewDelegate {
    func didTapSearchButton(date: (checkIn: String, checkOut: String)?) {
        dismiss(animated: true) {
            self.searchDelegate?.searchStayList(date: date)
        }
    }
}

// MARK:- UI & Layout

extension DatesFilterViewController {
    private func configureUI() {
        view.backgroundColor = .white
        titleView = DatesFilterTitleView.loadFromXib()
        fixedFooterView = DatesFilterFixedFooterView.loadFromXib()
        calendarCollectionView = CalendarCollectionView()
    }
    
    private func configureLayout() {
        view.addSubviews(
            titleView,
            fixedFooterView,
            calendarCollectionView)
        titleView.constraints(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: nil,
            trailingAnchor: view.trailingAnchor,
            size: CGSize(width: 0, height: DatesFilterTitleView.height))
        fixedFooterView.constraints(
            topAnchor: nil,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: view.bottomAnchor,
            trailingAnchor: view.trailingAnchor,
            size: CGSize(width: 0, height: DatesFilterFixedFooterView.height))
        calendarCollectionView.constraints(
            topAnchor: titleView.bottomAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: fixedFooterView.topAnchor,
            trailingAnchor: view.trailingAnchor,
            padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
}
