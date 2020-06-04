import UIKit

class DetailSectionView: UIView, ViewFromXib {

    @IBOutlet weak var titleLabel: UILabel!
    var contentView: ContentView!

    static let xibName = String(describing: DetailSectionView.self)

    static func loadFromXib(title: String?, contentView: ContentView) -> Self {
        let view = loadFromXib()

        view.titleLabel.text = title
        view.addContentView(contentView)

        return view
    }

    func addContentView(_ contentView: ContentView) {
        self.addSubview(contentView)
        self.contentView = contentView
        contentView.constraints(
            topAnchor: self.titleLabel.bottomAnchor,
            leadingAnchor: self.leadingAnchor,
            bottomAnchor: self.bottomAnchor,
            trailingAnchor: self.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 10)
        )
    }
}

protocol ContentView: UIView {
    func updateChanges()
}
