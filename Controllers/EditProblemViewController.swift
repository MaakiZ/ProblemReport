import UIKit
import MapKit
import CoreData

class EditProblemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    // MARK: - Outlets

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!

    // MARK: - Properties

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var selectedLocation: CLLocation?

    var problem: Problem?
    var managedObjectContext: NSManagedObjectContext?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Check if we have permission to use location services
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                startUpdatingLocation()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                showAlert(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.")
            @unknown default:
                fatalError("CLLocationManager.authorizationStatus has an unknown value.")
            }
        } else {
            showAlert(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.")
        }

        // Setup UI
        if let problem = problem {
            nameTextField.text = problem.name
            locationTextField.text = problem.location
            descriptionTextView.text = problem.problemDescription
            if let imageData = problem.photo {
                photoImageView.image = UIImage(data: imageData)
            }
            if let latitude = problem.latitude, let longitude = problem.longitude {
                let location = CLLocation(latitude: latitude, longitude: longitude)
                showLocationOnMap(location: location)
            }
        } else {
            // If no problem is passed in, set default location to current location
            selectedLocation = currentLocation
        }
    }

    // MARK: - Actions

    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        let alertController = UIAlertController(title: "Add a photo", message: nil, preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Take a photo", style: .default) { (_) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }

        let libraryAction = UIAlertAction(title: "Choose from library", style: .default) { (_) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(libraryAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: "Missing Name", message: "Please enter a name for the problem.")
            return
        }
        guard let location = locationTextField.text, !location.isEmpty else {
            showAlert(title: "Missing Location", message: "Please enter a location for the problem.")
            return
        }
        guard let problem = self.problem ?? Problem(context: CoreDataStack.shared.persistentContainer.viewContext)

    // Assign the problem object with new values
    problem.name = name
    problem.location = location
    problem.problemDescription = description

    if let selectedLocation = selectedLocation {
        problem.latitude = selectedLocation.coordinate.latitude
        problem.longitude = selectedLocation.coordinate.longitude
    }

    if let photo = photoImageView.image {
        problem.photo = photo.jpegData(compressionQuality: 0.8)
    }

    // Save the context
    do {
        try CoreDataStack.shared.persistentContainer.viewContext.save()
        navigationController?.popViewController(animated: true)
    } catch {
        showAlert(title: "Error", message: "Unable to save the problem.")
    }


// MARK: - Private methods

private func startUpdatingLocation() {
    locationManager.startUpdatingLocation()
    mapView.showsUserLocation = true
}

private func showLocationOnMap(location: CLLocation) {
    let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    mapView.setRegion(region, animated: true)

    // Add a pin to the map
    let annotation = MKPointAnnotation()
    annotation.coordinate = location.coordinate
    mapView.addAnnotation(annotation)

    selectedLocation = location
}

private func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
}

}

// MARK: - UIImagePickerControllerDelegate

extension EditProblemViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        photoImageView.image = image
    }
    dismiss(animated: true, completion: nil)
}
}

// MARK: - UINavigationControllerDelegate

extension EditProblemViewController: UINavigationControllerDelegate {

}

// MARK: - CLLocationManagerDelegate

extension EditProblemViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    currentLocation = location

    // If selected location is not set, then show the current location on map
    if selectedLocation == nil {
        showLocationOnMap(location: location)
    }
}

func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error getting user location: \(error.localizedDescription)")
}

func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
        startUpdatingLocation()
    case .denied, .restricted:
        showAlert(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.")
    case .notDetermined:
        break
    @unknown default:
        fatalError("CLLocationManager.authorizationStatus has an unknown value.")
    }
}
