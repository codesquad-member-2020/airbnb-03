import UIKit

final class ReserveButton: UIButton, RoundedBorder {
    override func awakeFromNib() {
        super.awakeFromNib()

        drawBorders(cornerRadius: 7 , borderWidth: 0)
    }
}
