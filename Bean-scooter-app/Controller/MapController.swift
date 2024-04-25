//
//  MapController.swift
//  Bean-scooter-app
//
//  Created by 박중권 on 4/22/24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var rentButton: UIButton!
    
    let mapManager = MapManager()
    
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
        rentButton.isHidden = false
        //스쿠터 데이터베이스 정보로 핀 배치
        let scooterPin = MKPointAnnotation()
        scooterPin.coordinate = CLLocationCoordinate2DMake(37.7882971863747, -122.4075784602224)
        mapView.addAnnotation(scooterPin)
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
    
    
    @IBAction func moveCurrentLocationBtn(_ sender: UIButton) {
        updateLocationMap(to: locationManager.location ?? CLLocation(), with: "현재 위치")    }
    //대여 하기 버튼을 눌렀을 때의 동작 정의
    //- 대여 확인 얼럿 진행, 대여 최종 완료시 대여 종료 동작인 completedRent 함수 호출
    @IBAction func didTapRentButton(_ sender: Any) {
        let rentProcessAlert = UIAlertController(title: "대여 진행", message: "기기의 시리얼 번호를 입력해주세요", preferredStyle: .alert)
        
        rentProcessAlert.addTextField() { (tf) in
            tf.placeholder = "Serial No."}
        
        let rent = UIAlertAction(title: "대여하기", style: .default) { rentalProcess in
            let confirmedRentAlert = UIAlertController(title: "대여 완료", message: "기기 대여가 완료되었습니다", preferredStyle: .alert)
            self.completedRent()
            //?? MKPointAnnotation 내용 업데이트
            //대여 완료시 코어데이터 저장 및 update 플로우(기기 배열의 데이터 업데이트) 작성 필요
            //대여 완료시 대여 버튼의 is hidden -> 다시 true로 변경
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        rentProcessAlert.addAction(cancel)
        rentProcessAlert.addAction(rent)
        present(rentProcessAlert, animated: true, completion: nil)
    }
    //대여 완료시의 동작 정의 - 핀 지우기, 대여 버튼 가리기
    func completedRent() {
        //핀을 모두 지워야 하나? 선택된 핀만 지워야 하겠죠...? 함수 수정 필요할듯
        mapView.removeAnnotations(mapView.annotations)
        self.rentButton.isHidden = true
    }
    
}

extension MapViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            mapManager.fetchRequest(textString: text) { result in
                switch result {
                case .success(let data):
                    if let lat = Double(data.documents[0].y), let lon = Double(data.documents[0].x) {
                        DispatchQueue.main.async {
                            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                            self.mapView.setRegion(region, animated: true)
                        }
                        
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "에러발생", message: "데이터 통신 중 \(error.localizedDescription) 이 발생했습니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
            
        }
    }
}

