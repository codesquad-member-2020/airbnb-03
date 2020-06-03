import UIKit

protocol SearchFooterViewDelegate: class {
    func didTapSearchButton()
    func didTapClearButton()
}

final class SearchFooterView: UIView {
    
    private enum Color {
        static let searchEnabled: UIColor? = UIColor(named: "button.enabled")
        static let searchDisabled: UIColor? = UIColor(named: "button.disabled")
    }
    
    @IBOutlet weak var searchButton: DatesFilterSearchButton! {
        didSet {
            configureSearchButton()
        }
    }
    @IBOutlet weak var clearButton: UIButton! {
        didSet {
            configureClearButton()
        }
    }
    
    weak var delegate: SearchFooterViewDelegate?
    
    override func draw(_ rect: CGRect) {
        drawEdgeLine(edge: .top, lineWidth: 0.3, lineColor: .lightGray)
    }
    
    private func configureSearchButton() {
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.setTitleColor(.darkGray, for: .disabled)
        searchButton.backgroundColor = Color.searchDisabled
        searchButton.tintColor = .black
        searchButton.isEnabled = false
    }
    
    private func configureClearButton() {
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.setTitleColor(.lightGray, for: .disabled)
        clearButton.isEnabled = false
    }
    
    func updateSearchButton(with isEnabled: Bool) {
        searchButton.isEnabled = isEnabled
        searchButton.backgroundColor = isEnabled ? Color.searchEnabled : Color.searchDisabled
        searchButton.tintColor = isEnabled ? .white : .black
    }
    
    func updateClearButton(with isEnabled: Bool) {
        clearButton.isEnabled = isEnabled
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
        delegate?.didTapSearchButton()
    }
    
    @IBAction func didTapClear(_ sender: Any) {
        delegate?.didTapClearButton()
    }
}
