import UIKit

class SearchFooterViewController: UIViewController {

    var searchFooterView: SearchFooterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureFooterView()
    }
    
    private func configureFooterView() {
        view.backgroundColor = .white
        searchFooterView = SearchFooterView.loadFromNib()
        view.addSubviews(searchFooterView)
        searchFooterView.constraints(
            topAnchor: nil,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            trailingAnchor: view.trailingAnchor)
    }
}
