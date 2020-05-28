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
        drawShadow(color: .lightGray,
                   radius: 4.0,
                   opacity: 0.5,
                   shouldRasterize: true)
    }

    private func drawBorder() {
        layer.masksToBounds = false
        layer.cornerRadius = Self.height / 2
        layer.borderWidth =  0
    }
}

