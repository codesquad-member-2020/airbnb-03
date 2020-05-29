import UIKit

class DatesFilterViewController: UIViewController {
    
    private var titleView: DatesFilterTitleView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureLayout()
    }
}

// MARK:- UI & Layout

extension DatesFilterViewController {
    private func configureUI() {
        view.backgroundColor = .white
        
        titleView = DatesFilterTitleView.loadFromXib()
    }
    
    private func configureLayout() {
        view.addSubviews(titleView)
        
        titleView.constraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                              leadingAnchor: view.leadingAnchor,
                              bottomAnchor: nil,
                              trailingAnchor: view.trailingAnchor,
                              size: .init(width: 0,
                                          height: DatesFilterTitleView.height))
    }
}
