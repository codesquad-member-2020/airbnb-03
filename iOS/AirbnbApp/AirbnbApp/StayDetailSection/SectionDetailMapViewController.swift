import MapKit

protocol Coordinatable {
    var latitude: Double { get }
    var longitude: Double { get }
}

class SectionDetailMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var coordinate: Coordinatable!

    override var prefersStatusBarHidden: Bool { true }

    override func viewDidLoad() {
        super.viewDidLoad()

        let annotation = makeAnnotation(coordinate)
        mapView.showAnnotations([annotation], animated: true)
    }

    private func makeAnnotation(_ coordinate: Coordinatable) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)

        return annotation
    }

    @IBAction func closeButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension CLLocationCoordinate2D: Coordinatable { }

struct Coordinate: Coordinatable {
    let latitude: Double
    let longitude: Double
}
