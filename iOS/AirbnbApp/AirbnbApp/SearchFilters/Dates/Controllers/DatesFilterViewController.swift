import UIKit

protocol DatesFilterViewControllerSearchDelegate: class {
    func searchStayList(date: (checkIn: String, checkOut: String)?)
}

final class DatesFilterViewController: UIViewController {
    
    private var titleView: DatesFilterTitleView!
    private var fixedFooterView: DatesFilterFixedFooterView!
    private var monthsCollectionView: MonthsCollectionView!
    private var monthsCollectionViewDataSource: MonthsCollectionViewDataSource!
    weak var searchDelegate: DatesFilterViewControllerSearchDelegate?
    
    private let spacingForItem: CGFloat = 16.0
    private let numberOfDaysAt: [Int] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    private var checkInDate: ReservationDate? = nil
    private var checkOutDate: ReservationDate? = nil
    private var totalReservationDates: [ReservationDates] = []
    private var firstDayOffset: Int = 0

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
        
        monthsCollectionViewDataSource = MonthsCollectionViewDataSource(
            totalReservationDates: totalReservationDates)
        monthsCollectionView.dataSource = monthsCollectionViewDataSource
        monthsCollectionView.reloadData()
    }
    
    private func configureDatesData() {
        for monthOffset in 0..<12 {
            // 월 계산
            let currentDate = ReservationDate(date: Date())
            let monthUpdatedDate = currentDate.after(monthOffset: monthOffset)
            var dayDatesByMonth = ReservationDates()
            for day in 1...numberOfDaysAt[monthUpdatedDate.month] {
                dayDatesByMonth.append(
                    ReservationDate(
                        year: monthUpdatedDate.year,
                        month: monthUpdatedDate.month,
                        day: day))
            }
            totalReservationDates.append(dayDatesByMonth)
        }
    }
}

// MARK:- Delegations Configuration

extension DatesFilterViewController {
    private func configureDelegates() {
        fixedFooterView.delegate = self
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
        monthsCollectionView = MonthsCollectionView()
    }
    
    private func configureLayout() {
        view.addSubviews(
            titleView,
            fixedFooterView,
            monthsCollectionView)
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
        monthsCollectionView.constraints(
            topAnchor: titleView.bottomAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: fixedFooterView.topAnchor,
            trailingAnchor: view.trailingAnchor)
    }
}
