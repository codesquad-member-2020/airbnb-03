import UIKit
import MapKit

class SectionMap: UIView, RoundedBorder {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    static var xibName: String = .init(describing: SectionMap.self)

    private weak var delegate: SectionMapDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        configure()
    }

    func updateMap(with annotation: MKPointAnnotation) {
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false

        mapView.showAnnotations([annotation], animated: true)
    }

    private func configure() {
        drawBorders(cornerRadius: 12, borderWidth: 0.1, borderColor: UIColor.white.cgColor)
        clipsToBounds = true
    }

    @IBAction func moreButtonTouched(_ sender: Any) {
        delegate?.didTapMoreLocationButton()
    }

    @IBAction func mapTouched(_ sender: Any) {
        delegate?.didTapMapView()
    }
}

extension SectionMap: ContentView {
    func needsDelegate() -> Bool {
        return true
    }

    func assignDelegate(_ delegate: SectionViewDelegate) {
        self.delegate = delegate as? SectionMapDelegate
    }
}
