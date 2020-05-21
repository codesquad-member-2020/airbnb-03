import UIKit

class FilterButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        drawBorder()
    }

    private func drawBorder() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderWidth =  1
        self.layer.borderColor = UIColor.systemGray.cgColor
    }
}

class DateFilterButton: FilterButton { }
class PeopleFilterButton: FilterButton { }
class PriceFilterButton: FilterButton { }
