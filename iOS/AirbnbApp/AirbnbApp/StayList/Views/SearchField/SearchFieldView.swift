import UIKit

final class SearchFieldView: UIView, ViewFromXib {

    static let xibName = String(describing: SearchFieldView.self)
    static let height: CGFloat = 40.0

    @IBOutlet weak var searchTextField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func configureTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        searchTextField.delegate = delegate
    }

    private func configure() {
        drawBorder()
        drawShadow()
    }

    private func drawShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shouldRasterize = true
    }

    private func drawBorder() {
        layer.masksToBounds = false
        layer.cornerRadius = Self.height / 2
        layer.borderWidth =  0
    }
}

