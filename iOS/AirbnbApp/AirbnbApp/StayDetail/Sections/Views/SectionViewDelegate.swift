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
    func didTapMoreSummaryButton()
}

protocol SectionAmenitiesDelegate: SectionViewDelegate {
    func didTapShowAllButton()
}

protocol SectionMapDelegate: SectionViewDelegate {
    func didTapMoreLocationButton()
    func didTapMapView()
}
