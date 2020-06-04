import Foundation

protocol ContentView: NeedsDelegate, ViewFromXib { }

protocol NeedsDelegate {
    func needsDelegate() -> Bool
    func assignDelegate(_ delegate: SectionViewDelegate)
}

extension NeedsDelegate {
    func assignDelegate(_ delegate: SectionViewDelegate) { }
}

protocol SectionViewDelegate: class { }

protocol SectionSummaryDelegate: SectionViewDelegate {
    func didTapMore()
}

protocol SectionAmenitiesDelegate: SectionViewDelegate {
    func didTouchShowAllButton()
}

protocol SectionMapDelegate: SectionViewDelegate {
    func didTouchMoreLocationButton()
}
