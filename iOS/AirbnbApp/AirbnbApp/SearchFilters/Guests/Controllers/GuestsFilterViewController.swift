import UIKit

final class GuestsFilterViewController: UIViewController {

    private var titleView: GuestsFilterTitleView!
    private var buttonSectionView: GuestsFilterButtonSectionView!
    private var saveButtonView: GuestsFilterSaveButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureLayout()
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
            bottomAnchor: nil,
            trailingAnchor: view.trailingAnchor)
        saveButtonView.constraints(
            topAnchor: nil,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            trailingAnchor: view.trailingAnchor,
            size: CGSize(width: 0, height: 48 + 16))
    }
}
