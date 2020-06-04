import UIKit

extension UIStackView {
    func resetArrangedSubViews() {
        guard arrangedSubviews.count != 0 else { return }

        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
