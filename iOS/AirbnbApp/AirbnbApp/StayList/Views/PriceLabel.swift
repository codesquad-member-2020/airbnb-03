import UIKit

class PriceLabel: UILabel {

    func updateWith(price: Int) {
        let attributedText = NSMutableAttributedString(string: "")
        attributedText.append(text: "\(price.priceFormat)$", fontSize: 17, weight: .bold)
        attributedText.append(text: " / night", fontSize: 17, weight: .light)
        self.attributedText = attributedText
    }
}

extension Int {
    var priceFormat: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
