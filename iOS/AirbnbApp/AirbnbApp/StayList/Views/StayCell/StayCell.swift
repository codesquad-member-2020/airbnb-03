import UIKit

final class StayCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: StayCell.self)
    static let reuseIdentifier: String = "StayCell"

    @IBOutlet weak var thumbImagePagingView: ThumbImagePagingView!
    @IBOutlet weak var saveButton: SaveButton!
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
        saveButton.updateImage(with: stay.saved)
    }
    
    func updateImage(at index: Int, data: Data) {
        thumbImagePagingView.updateImage(at: index, data: data)
    }
    
    override func prepareForReuse() {
        superHostLabel.isHidden = true
        thumbImagePagingView.prepareForReuse()
    }
    
    // MARK:- IBAction
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if saveButton.isSaved {
            saveButton.toggle()
        } else {
            animateSaveButton()
        }
    }
}

// MARK:- Save Button Animation

extension StayCell {
    private func animateSaveButton() {
        saveButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.4, options: .curveEaseOut, animations: {
            self.saveButton.toggle()
            self.saveButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
                self.saveButton.transform = .identity
            })
        })
    }
}
