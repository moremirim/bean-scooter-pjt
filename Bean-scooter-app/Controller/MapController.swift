//
//  MapController.swift
//  Bean-scooter-app
//
//  Created by 박중권 on 4/22/24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, FloatingTabBarDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    lazy var floatingTabBar: FloatingTabBar = {
        let tabBarWidth = view.frame.width - 20 // Adjusted width
        let tabBarHeight: CGFloat = 80
        let tabBarY = view.frame.height - tabBarHeight - 40 // Positioned away from bottom safe area by 10
        
        let tabBar = FloatingTabBar(frame: CGRect(x: 10, y: tabBarY, width: tabBarWidth, height: tabBarHeight))
        
        // Apply corner radius
        tabBar.layer.cornerRadius = 20
        
        // Apply shadow
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowRadius = 4
        
        tabBar.backgroundColor = .white
        tabBar.delegate = self
        return tabBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Add the tab bar as a subview of the view controller's view
        view.addSubview(floatingTabBar)
        // Bring the tab bar to front to ensure it's above other views
        view.bringSubviewToFront(floatingTabBar)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.startUpdatingLocation()
            updateLocationMap(to: location, with: "Current Location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateLocationMap(to location: CLLocation, with title: String?) {
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    // MARK: - FloatingTabBarDelegate
    
    func didSelectTab(at index: Int) {
//        switch index {
//        case 0:
//            let firstVC = storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
//            navigationController?.pushViewController(firstVC, animated: true)
//        case 1:
//            let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//            navigationController?.pushViewController(secondVC, animated: true)
//        case 2:
//            let thirdVC = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! SecondViewController
//            navigationController?.pushViewController(secondVC, animated: true)
//        case 3:
//            let fourthVC = storyboard?.instantiateViewController(withIdentifier: "FourthViewController") as! SecondViewController
//            navigationController?.pushViewController(secondVC, animated: true)
//        default:
//            break
            print("Selected tab at index: \(index)")
        }
    }
}
