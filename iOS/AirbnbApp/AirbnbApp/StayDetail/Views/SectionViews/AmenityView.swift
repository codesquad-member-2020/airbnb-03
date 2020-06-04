import UIKit

class AmenityView: UIView, ViewFromXib {
    static var xibName: String = .init(describing: AmenityView.self)

    var titleLabel: UILabel!
    var symbolImageView: UIImageView!

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, title: String, symbol: UIImage?) {
        super.init(frame: frame)

        makeTitleLabel(title: title)
        if let symbol = symbol {
            makeSymbolImageView(symbol: symbol)
        }
        self.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    }

    private func makeTitleLabel(title: String) {
        titleLabel = UILabel(frame: .init(x: 0, y: 0, width: self.bounds.width / 2, height: 20))
        titleLabel.text = title
        self.addSubview(titleLabel)
    }

    private func makeSymbolImageView(symbol: UIImage) {
        symbolImageView = UIImageView(image: symbol)
        symbolImageView.tintColor = .darkText
        self.addSubview(symbolImageView)

        symbolImageView.constraints(topAnchor: self.topAnchor,
                                    leadingAnchor: nil,
                                    bottomAnchor: nil,
                                    trailingAnchor: self.trailingAnchor
        )
    }
}
