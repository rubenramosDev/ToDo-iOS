
import UIKit
import MapKit
import Foundation

class TaskViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var boutonSave: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var customIn: UITextField!
    @IBOutlet weak var switchOption: UISwitch!
    @IBOutlet weak var mMapView: MKMapView!
    
    let dateFormater = DateFormatter()
    
    var locationManager:CLLocationManager!
    var currentLocationStr = "Current location"
    
    var task : ToDo?
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = task {
            customIn.text = task.titre
            
            let today = task.derniereMod
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .short
            labelDate.text = formatter1.string(from: today)
            imageView.image = UIImage(named: task.photo!)
            
            //TODO verify locqton
            if task.etat {
                switchOption.setOn(true, animated: true)
                determineCurrentLocation()
            }else {
                switchOption.setOn(false, animated: true)
            }
            
        }
    }
    

    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func switchOpt(_ sender: Any) {
        task?.etat = true
        determineCurrentLocation()
    }
    
 
    func textFieldDidChange(textField: UITextField) {
        if let text = customIn.text, text.isEmpty{
            boutonSave.isEnabled = false
        }else{
            boutonSave.isEnabled = true
        }
    }
    
    @IBAction override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var toDo = ToDo(titre: customIn.text!, etat: task!.etat)
        toDo.localisation = location
        task = toDo
     }
    
    //Location functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let mUserLocation:CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
      
        location = CLLocation(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        mMapView.setRegion(mRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
        
}





