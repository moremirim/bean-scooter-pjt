//
//  MapController.swift
//  Bean-scooter-app
//
//  Created by 박중권 on 4/22/24.
//

import Foundation
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView : MKMapView!
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.startUpdatingLocation()
            updateLocationMap(to: location, with: "현재 위치")

        }
        // 새로운 위치로 업로드
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 에러 발생시
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateLocationMap(to location: CLLocation, with title: String?)
    {
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
//        self.mapView.removeAnnotation(self.mapView.annotations as! MKAnnotation)
//        self.mapView.addAnnotation(point)
        print(location.coordinate)
        
        
//        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        let lat = location.coordinate.latitude
              let lon = location.coordinate.longitude
              let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        
        self.mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    //현재 위치 업데이트 버튼
    @IBAction func onLocationButtonTapped() {
        updateLocationMap(to: locationManager.location ?? CLLocation(), with: "현재 위치")
    }
    
    
}
