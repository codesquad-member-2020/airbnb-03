import UIKit

final class ThumbImagePagingView: UIView {

    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    private var imageStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureStackView(numberOfImage: Int, cornerRadius: CGFloat = 12) {
        pageControl.numberOfPages = numberOfImage
        
        for _ in 0..<numberOfImage {
            let imageView = ThumbImageView(cornerRadius: cornerRadius)
            imageStackView.addArrangedSubview(imageView)
            imageView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        }
    }
    
    func updateImage(at index: Int, data: Data) {
        let thumbImageViews = imageStackView.arrangedSubviews as! [ThumbImageView]
        thumbImageViews[index].image = UIImage(data: data)
    }

    func updateImage(at index: Int, image: UIImage) {
        let thumbImageViews = imageStackView.arrangedSubviews as! [ThumbImageView]
        thumbImageViews[index].image = image
    }

    func prepareForReuse() {
        pageControl.currentPage = 0
        scrollView.contentOffset.x = 0
        
        imageStackView.arrangedSubviews.forEach {
            imageStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    private func configure() {
        configureUI()
        configureScrollViewDelegate()
        configureLayout()
    }
    
    private func configureUI() {
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        pageControl = UIPageControl()
        pageControl.defersCurrentPageDisplay = true
        imageStackView = UIStackView()
    }
    
    private func configureScrollViewDelegate() {
        scrollView.delegate = self
    }
    
    private func updatePageControl(to index: Int) {
        guard pageControl.currentPage != index else { return }
        pageControl.currentPage = index
    }
}

// MARK:- ScrollViewDelegate
extension ThumbImagePagingView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        updatePageControl(to: pageIndex)
    }
}

// MARK:- Layout Configuration
extension ThumbImagePagingView {
    private func configureLayout() {
        addSubviews(scrollView,
                    pageControl)
        scrollView.addSubview(imageStackView)
        
        scrollView.fillSuperview()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        imageStackView.constraints(topAnchor: scrollView.contentLayoutGuide.topAnchor,
                                   leadingAnchor: scrollView.contentLayoutGuide.leadingAnchor,
                                   bottomAnchor: scrollView.contentLayoutGuide.bottomAnchor,
                                   trailingAnchor: scrollView.contentLayoutGuide.trailingAnchor)
        imageStackView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor).isActive = true
    }
}
