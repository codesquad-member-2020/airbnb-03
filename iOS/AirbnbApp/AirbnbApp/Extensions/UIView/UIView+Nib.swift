import UIKit

extension UIView {
    /// 클래스의 이름으로 nib 파일을 load한다.
    ///
    /// - Note: nib파일과 클래스명이 무조건 동일해야 하며 호출한 클래스명 타입으로 반환된다.
    static func loadFromNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing: self), bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
}
