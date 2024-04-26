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
    
    @IBOutlet weak var returnButton: UIButton!
    
    let mapManager = MapManager()
    let coordGenerater = CoordGenerator()
    
    var selectedAnnotation: MKPointAnnotation? // 선택된 Pin
    var isUsed: Bool = false
    var serialNumber: String = ""
    
    var locations: [CLLocationCoordinate2D] = [] // 거리 계산용 배열
    var modalViewController = ModalViewController() // 새로 보여줄 VC
    var dimmingView: UIView? // 어둡게 할 배경
        
    var dummyArray = [PinModel]()

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
        
        
        rentButton.isHidden = true
        returnButton.isHidden = true
        
        addDimmingView()
        
        dummyArray = coordGenerater.makingDummyArray()
        makingDummy()
    }
    
    // MARK: - Making Dummy pins
    func makingDummy() {
        for i in dummyArray.indices {
            let coordinate = CLLocationCoordinate2D(latitude: dummyArray[i].y, longitude: dummyArray[i].x)
            addMark(coordinate: coordinate, serial: dummyArray[i].id)
        }
    }
    
    // MARK: - Method for showing or hiding buttons
    // 대여의 상태를 보고 버튼을 숨기거나 보여줌
    func setbuttonHidden(isStatus: Bool) {
        
        if !isStatus {  // false 대여를 하지 않은 상태
            rentButton.isHidden = true
            returnButton.isHidden = true
        } else { // 대여를 한 상태라면
            rentButton.isHidden = true
            returnButton.isHidden = false
        }
    }
    
    // MARK: - Methods for Locations (MapView)
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
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    
    // MARK: - Methods for Features (Rent, Return)

    @IBAction func moveCurrentLocationBtn(_ sender: UIButton) {
        updateLocationMap(to: locationManager.location ?? CLLocation(), with: "현재 위치")    }
    
    //대여 하기 버튼을 눌렀을 때의 동작 정의
    //대여 확인 얼럿 진행, 대여 최종 완료시 대여 종료 동작인 completedRent 함수 호출
    @IBAction func didTapRentButton(_ sender: Any) {
        let rentProcessAlert = UIAlertController(title: "대여 진행", message: "기기의 시리얼 번호를 입력해주세요", preferredStyle: .alert)
        
        rentProcessAlert.addTextField() { (tf) in
            tf.placeholder = "Serial No."
            
            if let inputSerial = tf.text {
                self.serialNumber = inputSerial
            }
        }
        
        let rent = UIAlertAction(title: "대여하기", style: .default) { _ in
            self.completedRent(didSelect: self.selectedAnnotation!)
            
            if let coordinate = self.selectedAnnotation?.coordinate {
                self.locations.append(coordinate)
            }
           
            DispatchQueue.main.async {
                
                self.isUsed = true
                self.setbuttonHidden(isStatus: self.isUsed)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        rentProcessAlert.addAction(cancel)
        rentProcessAlert.addAction(rent)
        present(rentProcessAlert, animated: true, completion: nil)
        
        
        
    }
    
    
    //대여 완료시의 동작 정의
    func completedRent(didSelect annotation: any MKAnnotation) {
        let pin = annotation
        mapView.removeAnnotation(pin)
    }
    
    // pin 추가.
    func addMark(coordinate: CLLocationCoordinate2D, serial: String) {
        
        let pin = MKPointAnnotation()
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { (placemarks, error) in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            guard let address = placeMark else { return }
            
            pin.title = "기기번호: \(serial)"
            pin.subtitle = "현재위치: \(address.thoroughfare ?? "Apple Store")"
            
            pin.coordinate = coordinate
            self.mapView.addAnnotation(pin)
        }

    }
    
    // 반납 버튼
    @IBAction func returnScooterBtn(_ sender: UIButton) {
        DispatchQueue.global().async { [weak self] in
            if CLLocationManager.locationServicesEnabled() {
                self?.locationManager.requestWhenInUseAuthorization()
                let currentLocation = self?.locationManager.location
                
                self?.addMark(coordinate: CLLocationCoordinate2D(latitude: currentLocation?.coordinate.latitude ?? 37.503702192, longitude: currentLocation?.coordinate.longitude ?? 127.025313873406), serial: self?.serialNumber ?? "1D1Fvfvt3455")
                self?.locations.append(currentLocation!.coordinate)
            }
            
        }
        isUsed = false
        setbuttonHidden(isStatus: isUsed)
        
        let alert = UIAlertController(title: "반납완료", message: "킥보드 반납이 완료되었습니다.\n안녕히 가세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
        let distance = calculateTripDistance()
        let finTime = Date.now
        RecordSingleton.shared.array.append(RecordModel(distance: distance, time: finTime))
        locations.removeAll() // 거리 계산후 배열 초기화.
    }
    
    // 거리계산 함수.
    func calculateTripDistance() -> Int{
        
        var total: Double = 0.0
        for i in 0..<locations.count - 1 {
            let start = locations[i]
            let end = locations[i + 1]
            let distance = getDistance(from: start, to: end)
            total += distance
        }
       
        return Int(total)
    }
    
    func getDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distance(from: to)
    }
    
    // MARK: - Methods for Gestures
    @objc func showbtn() {
        rentButton.isHidden = false
    }
    
    @objc func showView() {
        
        let modalVC = self.modalViewController
        modalVC.addressLabel.text = selectedAnnotation?.subtitle
        modalVC.serialLabel.text = selectedAnnotation?.title
        
        
        // 사이드 메뉴 뷰 컨트롤러를 자식으로 추가하고 뷰 계층 구조에 추가.
        self.addChild(modalVC)
        self.view.addSubview(modalVC.view)
        
        let menuWidth = self.view.frame.width // 가로는 현재 화면과 동일하게
        let menuHeight = self.view.frame.height * 0.3 // 높이만 30%로 설정
        
        // 사이드 메뉴의 시작 위치를 화면 아래로 설정.
        modalVC.view.frame = CGRect(x: 0, y: view.frame.height, width: menuWidth, height: menuHeight)
        
        // 어두운 배경 뷰를 보이게 한다.
        self.dimmingView?.isHidden = false
        self.dimmingView?.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            // 사이드 메뉴를 화면에 표시.
            modalVC.view.frame = CGRect(x: 0, y: self.view.frame.height - menuHeight, width: menuWidth, height: menuHeight)
            // 어두운 배경 뷰의 투명도를 조절.
            self.dimmingView?.alpha = 0.5
        })
    }
    
    // MARK: - ModalView
    private func addDimmingView() {
        
        dimmingView = UIView(frame: self.view.bounds)
        dimmingView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView?.isHidden = true
        view.addSubview(dimmingView!)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDimmingViewTap))
        dimmingView?.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func handleDimmingViewTap() {
        let modalVC = self.modalViewController
        
        UIView.animate(withDuration: 0.3, animations: {
            modalVC.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
            self.dimmingView?.alpha = 0
        }) { (finished) in
            modalVC.view.removeFromSuperview()
            modalVC.removeFromParent()
            self.dimmingView?.isHidden = true
        }
    }
}


// MARK: - SearchBar
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

// MARK: - AnnotationView
extension MapViewController: MKMapViewDelegate {
    
    // AnnotaionView 생성
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "customPin")
        
        if annotationView == nil {
            // view 생성
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .infoLight)
            annotationView?.rightCalloutAccessoryView = btn
            let click = UITapGestureRecognizer(target: self, action: #selector(showbtn))
            annotationView?.addGestureRecognizer(click)
            let btnClick = UITapGestureRecognizer(target: self, action: #selector(showView))
            btn.addGestureRecognizer(btnClick)
            
            
        } else {
            annotationView?.annotation = annotation
        }
        
        // pin image 조절 및 등록
        let pinImage = UIImage(named: "scooterPin")
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContext(size)
        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        annotationView?.image = resizedImage
        
        return annotationView
    }
    
    // 100m 벗어나면 alert 표시
    func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
        
        let pin = annotation
        let currentLocation = mapView.userLocation.location
        
        guard let distance = currentLocation?.distance(from: CLLocation(latitude: pin.coordinate.latitude, longitude: pin.coordinate.longitude)) else {
            fatalError("Can't get distance from Pin")
        }
        
        if distance > 100.0 {
            rentButton.isHidden = true
            DispatchQueue.main.async {
                
                let alert = UIAlertController(title: "구역 외 킥보드 접근", message: "100m 를 넘어선 킥보드는 이용이 불가합니다.\n선택한 킥보드와의 거리는 \(Int(distance))m 입니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
        }
        
        if isUsed {
            rentButton.isHidden = true
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedAnnotation = view.annotation as? MKPointAnnotation
    }

}
