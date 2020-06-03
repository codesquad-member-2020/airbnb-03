import UIKit

final class GuestsFilterViewController: UIViewController {

    private var titleView: GuestsFilterTitleView!
    private var buttonSectionView: GuestsFilterButtonSectionView!
    private var saveButtonView: GuestsFilterSaveButtonView!
    
    private var guests: (adults: Int, children: Int, infants: Int) = (1, 0, 0) {
        didSet {
            buttonSectionView.update(with: guests)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        configureDelegates()
    }
    
    private func configureDelegates() {
        configureGuestsFilterButtonSectionViewDelegate()
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

// MARK:- UI & Layout

extension GuestsFilterViewController {
    private func configureUI() {
        view.backgroundColor = .white
        
        titleView = GuestsFilterTitleView.loadFromXib()
        buttonSectionView = GuestsFilterButtonSectionView.loadFromXib()
        saveButtonView = GuestsFilterSaveButtonView.loadFromXib()
    }
    
    private func configureLayout() {
        view.addSubviews(
            titleView,
            buttonSectionView,
            saveButtonView)
        titleView.constraints(
            topAnchor: view.topAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: nil,
            trailingAnchor: view.trailingAnchor)
        buttonSectionView.constraints(
            topAnchor: titleView.bottomAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: saveButtonView.topAnchor,
            trailingAnchor: view.trailingAnchor)
        saveButtonView.constraints(
            topAnchor: nil,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            trailingAnchor: view.trailingAnchor,
            size: CGSize(width: 0, height: 48 + 16))
    }
}
