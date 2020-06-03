import UIKit

protocol GuestsFilterSearchDelegate: class {
    func searchStayList(guests: (adults: Int?, children: Int?, infants: Int?))
}

final class GuestsFilterViewController: SearchFooterViewController {

    private var titleView: GuestsFilterTitleView!
    private var buttonSectionView: GuestsFilterButtonSectionView!
    
    private let initialGuests: (adults: Int, children: Int, infants: Int) = (1, 0, 0)
    private var guests: (adults: Int, children: Int, infants: Int) = (1, 0, 0) {
        didSet {
            didChangedGuests()
        }
    }
    
    weak var searchDelegate: GuestsFilterSearchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        configureDelegates()
    }
    
    func updateGuests(_ guests: (adults: Int?, children: Int?, infants: Int?)) {
        self.guests = (guests.adults ?? 0, guests.children ?? 0, guests.infants ?? 0)
        if self.guests == initialGuests {
            buttonSectionView.reset()
            searchFooterView.updateSearchButton(with: false)
            searchFooterView.updateClearButton(with: false)
        }
    }
    
    private func configureDelegates() {
        configureGuestsFilterButtonSectionViewDelegate()
        configureSearchFooterViewDelegate()
    }
    
    private func didChangedGuests() {
        buttonSectionView.update(with: guests)
        if guests.adults == 0 && guests.children == 0 {
            searchFooterView.updateSearchButton(with: false)
        } else {
            searchFooterView.updateSearchButton(with: true)
        }
        if guests != initialGuests {
            searchFooterView.updateClearButton(with: true)
        } else {
            searchFooterView.updateClearButton(with: false)
        }
    }
}

// MARK:- GuestsManagementDelegate

extension GuestsFilterViewController: GuestsManagementDelegate {
    private func configureGuestsFilterButtonSectionViewDelegate() {
        buttonSectionView.delegate = self
    }
    
    func didTapChangeGuestsButton(guestsChanges: (adults: Int, children: Int, infants: Int)) {
        guests.adults += guestsChanges.adults
        guests.children += guestsChanges.children
        guests.infants += guestsChanges.infants
    }
}

// MARK:- SearchFooterViewDelegate

extension GuestsFilterViewController: SearchFooterViewDelegate {
    private func configureSearchFooterViewDelegate() {
        searchFooterView.delegate = self
    }
    
    func didTapSearchButton() {
        let adults = guests.adults != 0 ? guests.adults : nil
        let children = guests.children != 0 ? guests.children : nil
        let infants = guests.infants != 0 ? guests.infants : nil
        let guests = (adults, children, infants)
        searchDelegate?.searchStayList(guests: guests)
        dismiss(animated: true)
    }
    
    func didTapClearButton() {
        guests = initialGuests
        buttonSectionView.reset()
        searchFooterView.updateClearButton(with: false)
    }
}

// MARK:- UI & Layout

extension GuestsFilterViewController {
    private func configureUI() {
        view.backgroundColor = .white
        
        titleView = GuestsFilterTitleView.loadFromXib()
        buttonSectionView = GuestsFilterButtonSectionView.loadFromNib()
    }
    
    private func configureLayout() {
        view.addSubviews(
            titleView,
            buttonSectionView)
        titleView.constraints(
            topAnchor: view.topAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: nil,
            trailingAnchor: view.trailingAnchor)
        buttonSectionView.constraints(
            topAnchor: titleView.bottomAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: searchFooterView.topAnchor,
            trailingAnchor: view.trailingAnchor)
    }
}
