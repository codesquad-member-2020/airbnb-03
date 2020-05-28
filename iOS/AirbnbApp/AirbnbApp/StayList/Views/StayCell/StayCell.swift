import UIKit

final class StayCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: StayCell.self)
    static let reuseIdentifier: String = "StayCell"

    @IBOutlet weak var thumbImagePagingView: ThumbImagePagingView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var reviewLabel: ReviewLabel!
    @IBOutlet weak var superHostLabel: SuperHostLabel!
    @IBOutlet weak var placeTypeAndCityLabel: PlaceTypeAndCityLabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: PriceLabel!
    
    func update(with stay: Stay) {
        reviewLabel.updateWith(reviewAverage: stay.reviewAverage,
                                    numberOfReviews: stay.numberOfReviews)
        placeTypeAndCityLabel.updateWith(type: stay.placeType,
                                              city: stay.city)
        titleLabel.text = stay.title
        priceLabel.updateWith(price: stay.price)
        thumbImagePagingView.configureStackView(numberOfImage: stay.images.count)
        superHostLabel.isHidden = stay.hostType != "super"
        #warning("update SaveButton status")
    }
    
    func updateImage(at index: Int, data: Data) {
        thumbImagePagingView.updateImage(at: index, data: data)
    }
    
    override func prepareForReuse() {
        superHostLabel.isHidden = true
        thumbImagePagingView.prepareForReuse()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        #warning("Save Stay Action 구현")
    }
}
