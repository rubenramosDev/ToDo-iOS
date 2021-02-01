
import UIKit
import MapKit

class ToDo: NSObject {
    
    var titre:String
    var etat:Bool
    var derniereMod:Date
    var photo:String?
    var localisation:CLLocation?
    
    let latitude : CLLocationDegrees = 38.5
    let longitude : CLLocationDegrees = 98.5
    
    init(titre:String, etat:Bool) {
        self.titre = titre;
        self.etat = etat;
        self.derniereMod = Date();
        self.photo = "img"
        self.localisation = CLLocation(latitude: 48.870502, longitude: 2.304897)
    }
    
    static func loadSampleToDos() -> [ToDo]{
        let tasks = [
        ToDo(titre: "Task 1", etat: false),
        ToDo(titre: "Task 2", etat: false),
        ToDo(titre: "Task 3", etat: false)
    ]
        return tasks
    }

}

