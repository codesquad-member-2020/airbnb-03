import UIKit

class StayCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: StayCell.self)
    static let reuseIdentifier: String = "StayCell"

    @IBOutlet weak var thumbImagePagingView: ThumbImagePagingView!
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
        thumbImagePagingView.configureStackView(numberOfImage: 7)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        #warning("Save Stay Action 구현")
    }
}
