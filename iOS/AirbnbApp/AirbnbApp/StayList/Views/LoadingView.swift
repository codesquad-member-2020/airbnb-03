import UIKit

final class LoadingView: UIView {
    
    private var activityIndicatorView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func startLoadingAnimation() {
        activityIndicatorView.startAnimating()
    }
    
    func stopLoadingAnimation() {
        activityIndicatorView.stopAnimating()
    }
    
    private func configure() {
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        backgroundColor = .white
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .darkGray
    }
    
    private func configureLayout() {
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview(constantX: 0, constantY: -16)
    }
}
