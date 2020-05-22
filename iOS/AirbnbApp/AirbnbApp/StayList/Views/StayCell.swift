import UIKit

class StayCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: StayCell.self)
    static let reuseIdentifier: String = "StayCell"

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
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
    }
    
    func configureScrollViewDelegate(delegate: UIScrollViewDelegate) {
        scrollView.delegate = delegate
    }
    
    private func configureControlPage(numberOfPage: Int) {
        pageControl.numberOfPages = numberOfPage
    }
    
    func updateThumbnailImage(with index: Int) {
        pageControl.currentPage = index
    }
}
