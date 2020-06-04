import UIKit

protocol SearchFilterViewTapDelegate: class {
    func didTapDatesFilter()
    func didTapGuestsFilter()
}

final class SearchFilterView: UIView, ViewFromXib {
    
    static let xibName = String(describing: SearchFilterView.self)
    static let height: CGFloat = 40
    
    @IBOutlet weak var guestsFilterButton: FilterButton!
    
    weak var delegate: SearchFilterViewTapDelegate?
    
    @IBAction func didTapDatesFilter(_ sender: Any) {
        delegate?.didTapDatesFilter()
    }
    
    @IBAction func didTapGuestsFilter(_ sender: Any) {
        delegate?.didTapGuestsFilter()
    }
    
    func updateGuestsFiltered(with filtered: Bool) {
        guestsFilterButton.update(with: filtered)
    }
}
