import UIKit

protocol GuestsManagementDelegate: class {
    func didTapChangeGuestsButton(guestsChanges: (adults: Int, children: Int, infants: Int))
}

final class GuestsFilterButtonSectionView: UIView {
    
    @IBOutlet weak var adultsDecreaseButton: UIButton!
    @IBOutlet weak var adultsIncreaseButton: UIButton!
    @IBOutlet weak var childrenDecreaseButton: UIButton!
    @IBOutlet weak var childrenIncreaseButton: UIButton!
    @IBOutlet weak var infantsDecreaseButton: UIButton!
    @IBOutlet weak var infantsIncreaseButton: UIButton!
    
    @IBOutlet weak var adultsLabel: UILabel!
    @IBOutlet weak var childrenLabel: UILabel!
    @IBOutlet weak var infantsLabel: UILabel!
    
    private let maximumGuests: Int = 16
    private let minimumAdults: Int = 1
    weak var delegate: GuestsManagementDelegate?
    
    @IBAction func didTapAdultsDecreaseButton(_ button: UIButton) {
        delegate?.didTapChangeGuestsButton(guestsChanges: (-1, 0, 0))
        animateButton(button)
    }
    
    @IBAction func didTapAdultsIncreaseButton(_ button: UIButton) {
        delegate?.didTapChangeGuestsButton(guestsChanges: (+1, 0, 0))
        animateButton(button)
    }
    
    @IBAction func didTapChildrenDecreaseButton(_ button: UIButton) {
        delegate?.didTapChangeGuestsButton(guestsChanges: (0, -1, 0))
        animateButton(button)
    }
    
    @IBAction func didTapChildrenIncreaseButton(_ button: UIButton) {
        delegate?.didTapChangeGuestsButton(guestsChanges: (0, +1, 0))
        animateButton(button)
    }
    
    @IBAction func didTapInfantsDecreaseButton(_ button: UIButton) {
        delegate?.didTapChangeGuestsButton(guestsChanges: (0, 0, -1))
        animateButton(button)
    }
    
    @IBAction func didTapInfantsIncreaseButton(_ button: UIButton) {
        delegate?.didTapChangeGuestsButton(guestsChanges: (0, 0, +1))
        animateButton(button)
    }
    
    func update(with guests: (adults: Int, children: Int, infants: Int)) {
        adultsLabel.text = String(guests.adults)
        childrenLabel.text = String(guests.children)
        infantsLabel.text = String(guests.infants)
        
        adultsDecreaseButton.isEnabled = (guests.adults > minimumAdults)
        childrenDecreaseButton.isEnabled = (guests.children > 0)
        infantsDecreaseButton.isEnabled = (guests.infants > 0)
        
        [adultsIncreaseButton, childrenIncreaseButton, infantsIncreaseButton].forEach {
            $0?.isEnabled = (guests.adults + guests.children + guests.infants < maximumGuests)
        }
    }
    
    private func animateButton(_ button: UIButton) {
        button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        button.alpha = 0.4
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.4, options: .curveEaseOut, animations: {
            button.alpha = 1
            button.transform = .identity
        })
    }
}
