import UIKit

protocol ViewFromXib {
    static var xibName: String { get }
}

// TODO: Return키 델리게이트, 그림자 효과
class SearchTextField: UIView, ViewFromXib {
    static let xibName = String(describing: SearchTextField.self)
}

