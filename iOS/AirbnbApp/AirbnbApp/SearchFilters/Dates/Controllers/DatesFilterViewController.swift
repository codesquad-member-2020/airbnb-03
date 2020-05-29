import UIKit

protocol DatesFilterViewControllerSearchDelegate: class {
    func searchStayList(date: (checkIn: String, checkOut: String)?)
}

final class DatesFilterViewController: UIViewController {
    
    private var titleView: DatesFilterTitleView!
    private var fixedFooterView: DatesFilterFixedFooterView!
    private var monthsCollectionView: MonthsCollectionView!
    weak var searchDelegate: DatesFilterViewControllerSearchDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureDelegates()
        configureLayout()
    }
}

// MARK:- Delegations Configuration

extension DatesFilterViewController {
    private func configureDelegates() {
        fixedFooterView.delegate = self
    }
}

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
        view.addSubviews(titleView,
                         fixedFooterView,
                         monthsCollectionView)
        
        titleView.constraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                              leadingAnchor: view.leadingAnchor,
                              bottomAnchor: nil,
                              trailingAnchor: view.trailingAnchor,
                              size: .init(width: 0,
                                          height: DatesFilterTitleView.height))
        fixedFooterView.constraints(topAnchor: nil,
                                    leadingAnchor: view.leadingAnchor,
                                    bottomAnchor: view.bottomAnchor,
                                    trailingAnchor: view.trailingAnchor,
                                    size: .init(width: 0,
                                                height: DatesFilterFixedFooterView.height))
        monthsCollectionView.constraints(topAnchor: titleView.bottomAnchor,
                                         leadingAnchor: view.leadingAnchor,
                                         bottomAnchor: fixedFooterView.topAnchor,
                                         trailingAnchor: view.trailingAnchor)
    }
}
