import Foundation
import UIKit
import CoreData
import CoreLocation

class Problem: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var location: String
    @NSManaged var problemDescription: String
    @NSManaged var photo: Data?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double

    convenience init(name: String, location: String, problemDescription: String, photo: UIImage?, latitude: Double, longitude: Double, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Problem", in: context)!
        self.init(entity: entity, insertInto: context)

        self.name = name
        self.location = location
        self.problemDescription = problemDescription
        self.latitude = latitude
        self.longitude = longitude

        if let photo = photo {
            self.photo = photo.pngData()
        }
    }

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
