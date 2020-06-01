import UIKit

class DetailSectionView: UIView, ViewFromXib {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!

    static let xibName = String(describing: DetailSectionView.self)

    static func loadFromXib(titleText: String?, handler: (Self) -> Void) -> Self {
        let view = loadFromXib()
        view.titleLabel.text = titleText
        handler(view)

        return view
    }

    func addSubContentViews(_ views: UIView...) {
        views.forEach { contentView.addSubview($0) }
    }
    @IBAction func buttonTouched(_ sender: Any) {
        print("button touched in view")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitTestView = super.hitTest(point, with: event)
        print(hitTestView)
        return hitTestView
    }
}
