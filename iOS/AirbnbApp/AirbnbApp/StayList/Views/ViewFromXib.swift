import UIKit

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

