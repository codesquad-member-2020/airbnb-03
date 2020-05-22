import UIKit

class StayCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: StayCell.self)
    static let reuseIdentifier: String = "StayCell"

    @IBOutlet weak var scrollView: UIScrollView!
    private var thumbScrollViewDelegate: ThumbScrollViewDelegate!
    @IBOutlet weak var thumbImageStackView: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var reviewLabel: ReviewLabel!
    @IBOutlet weak var superHostLabel: SuperHostLabel!
    @IBOutlet weak var placeTypeAndCityLabel: PlaceTypeAndCityLabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: PriceLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        reviewLabel.updateWith(reviewAverage: 4.67, numberOfReviews: 47)
        placeTypeAndCityLabel.updateWith(type: "Entire Apartment", city: "Upper East Side")
        titleLabel.text = "Modern luxury studio in Gangnam! 5sec to Station"
        priceLabel.updateWith(price: 1890)
        
        configureScrollViewDelegate()
        configureButtonAction()
    }
    
    private func configureScrollViewDelegate() {
        thumbScrollViewDelegate = ThumbScrollViewDelegate()
        scrollView.delegate = thumbScrollViewDelegate
    }
    
    private func configureButtonAction() {
        saveButton.addTarget(self, action: #selector(saveStay), for: .touchUpInside)
    }
    
    @objc private func saveStay() {
        #warning("Save Stay Action 구현")
    }
    
    private func configureControlPage(numberOfPage: Int) {
        pageControl.numberOfPages = numberOfPage
    }
    
    func updateThumbnailImage(with index: Int) {
        pageControl.currentPage = index
    }
}
