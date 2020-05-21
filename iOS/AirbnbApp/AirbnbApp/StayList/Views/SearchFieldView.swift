import UIKit

class SearchFieldView: UIView, ViewFromXib {

    static let xibName = String(describing: SearchFieldView.self)

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
        layer.cornerRadius = 24
        layer.borderWidth =  0
    }
}

