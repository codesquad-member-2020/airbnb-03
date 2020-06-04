import UIKit

extension UIView {
    /// 줄어들었다가 원래 크기로 돌아오는 탭 애니메이션
    /// - Parameters:
    ///   - initialScale: 처음 줄어드는 `scale`을 지정합니다. default 값은 0.8로 0.0과 1.0 사이에서 값을 정하면 좋습니다.
    ///   - initialAlpha: 처음 지정되는 view의 alpha값입니다. default 값은 1.0으로 따로 지정하지 않으면 투명도가 적용되지 않습니다.
    ///   - withDuration: 애니메이션이 진행되는 총 시간입니다.
    func animateTap(
        initialScale: CGFloat = 0.8,
        initialAlpha: CGFloat = 1.0,
        withDuration: Double) {
        
        self.transform = CGAffineTransform(scaleX: initialScale, y: initialScale)
        self.alpha = initialAlpha
        
        UIView.animate(
            withDuration: withDuration,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1.4,
            options: .curveEaseOut,
            animations: {
                self.alpha = 1
                self.transform = .identity
        })
    }
}
