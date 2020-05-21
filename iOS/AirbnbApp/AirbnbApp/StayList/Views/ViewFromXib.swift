import UIKit

/// Xib에 대응하는 뷰를 불러오기 위한 프로토콜
protocol ViewFromXib: UIView {
    static var xibName: String { get }

    static func loadFromXib() -> Self
}

extension ViewFromXib {
    static func loadFromXib() -> Self {
        guard let view = Bundle.main.loadNibNamed(Self.xibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("Failed to load from xib: \(Self.self)")
        }
        return view
    }
}

