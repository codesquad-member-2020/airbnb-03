import UIKit

/// 검색 필터 버튼. 상위 클래스
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

/// 각 버튼 대응
class DateFilterButton: FilterButton { }
class PeopleFilterButton: FilterButton { }
class PriceFilterButton: FilterButton { }
