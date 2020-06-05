import MapKit

class MapFilterViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var stays: [Stay]!

    override var prefersStatusBarHidden: Bool { true }

    override func viewDidLoad() {
        super.viewDidLoad()

        let annotations: [MKPointAnnotation] = stays.map {
            let coordinate = Coordinate(latitude: $0.latitude, longitude: $0.longitude)
            let title = "$\($0.price)"
            return makeAnnotation(coordinate, title: title)
        }
        mapView.showAnnotations(annotations, animated: true)
    }

    private func makeAnnotation(_ coordinate: Coordinatable, title: String?) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        annotation.title = title

        return annotation
    }

    @IBAction func closeButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
}
