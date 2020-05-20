import UIKit

class StayCell: UICollectionViewCell {
    
    static let nibName: String = String(describing: StayCell.self)
    static let reuseIdentifier: String = "StayCell"

    @IBOutlet weak var reviewLabel: ReviewLabel!
    @IBOutlet weak var superHostLabel: SuperHostLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        reviewLabel.updateWith(reviewAverage: 4.67, numberOfReviews: 47)
    }
}
