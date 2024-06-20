//
//  RestaurantMapViewController.swift
//  Travel
//
//  Created by NERO on 6/19/24.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

enum LocationCategory {
    case preset
    case user
    case allRestaurant
    case filteredRestaurant
}

class RestaurantMapViewController: UIViewController {
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    let userLocationButton = {
        let button = UIButton()
        button.setImage(UIImages.location, for: .normal)
        button.contentMode = .scaleAspectFill
        button.tintColor = .systemCyan
        return button
    }()
    
    let pickerView = UIPickerView()
    let categoryList = ["한식", "카페", "중식", "분식", "일식", "경양식", "양식"]
    var restaurantList = RestaurantInfo.restaurantList
    var filteredList: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        checkLocationAuthorization()
        locationManager.delegate = self
    }
}

extension RestaurantMapViewController {
    func configureNavigationBar() {
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .map
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        
        let choice = UIBarButtonItem(image: UIImages.choice, style: .plain, target: self, action: #selector(choiceButtonClicked))
        choice.tintColor = .red
        navigationItem.rightBarButtonItem = choice
    }
    
    @objc func choiceButtonClicked() {
        configureCategoryPicker()
    }
}

//MARK: - Location
extension RestaurantMapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        let isEnabled = CLLocationManager.locationServicesEnabled()
        
        switch isEnabled {
        case true:
            let status = locationManager.authorizationStatus
            requestLocationAuthorization(status)
            
        case false:
            configureAnnotation(.preset)
        }
    }
    
    func requestLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            configureAnnotation(.preset)
            requestAuthorizationChange()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            configureAnnotation(.user)
        default:
            configureAnnotation(.preset)
        }
    }
    
    func requestAuthorizationChange() {
        let alert = UIAlertController(title: "이런! 위치 서비스를 사용할 수 없어요", message: "'개인정보 보호 및 보안'에서 위치 서비스를 활성화해 주세요", preferredStyle: .alert)
        
        let openSetting = UIAlertAction(title: "설정하러 가기", style: .default) { _ in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(openSetting)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            addAnnotaion(list: nil, latitude: coordinate.latitude, longitude: coordinate.longitude, title: "현재 위치")
        }
        locationManager.stopUpdatingLocation()
    }
}

//MARK: - Map
extension RestaurantMapViewController {
    func configureAnnotation(_ location: LocationCategory) {
        mapView.removeAnnotations(mapView.annotations)
        
        switch location {
        case .preset:
            addAnnotaion(list: nil, latitude: 37.517474, longitude: 126.907357, title: "🌱")
        case .user:
            return
        case .allRestaurant:
            addAnnotaion(list: restaurantList, latitude: nil, longitude: nil, title: nil)
        case .filteredRestaurant:
            addAnnotaion(list: filteredList, latitude: nil, longitude: nil, title: nil)
        }
    }
    
    func addAnnotaion(list: [Restaurant]?, latitude: Double?, longitude: Double?, title: String?) {
        if let list {
            configureMapView(latitude: list.last!.latitude, longitude: list.last!.longitude)
            list.forEach {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake($0.latitude, $0.longitude)
                annotation.title = $0.name
                mapView.addAnnotation(annotation)
            }
        } else {
            guard let latitude, let longitude, let title else { return }
            configureMapView(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            annotation.title = title
            mapView.addAnnotation(annotation)
        }
    }
    
    func configureMapView(latitude: Double, longitude: Double) {
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.setRegion(region, animated: true)
        configureLocationButton()
    }
    
    func configureLocationButton() {
        mapView.addSubview(userLocationButton)
        userLocationButton.snp.makeConstraints {
            $0.leading.top.equalTo(mapView).offset(20)
            $0.size.equalTo(50)
        }
        
        userLocationButton.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
    }
    
    @objc func locationButtonClicked() {
        checkLocationAuthorization()
    }
}

//MARK: - Search
extension RestaurantMapViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func configureCategoryPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let alert = configureCategoryAlert()
        alert.view.addSubview(pickerView)
        pickerView.snp.makeConstraints {
            $0.center.equalTo(alert.view)
            $0.width.equalTo(250)
        }
    }
    
    func configureCategoryAlert() -> UIAlertController {
        let alert = UIAlertController(title: "📍 어디로 갈까요?", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        let selectAction = UIAlertAction(title: "검색", style: .destructive) { _ in
            let selectedRow = self.pickerView.selectedRow(inComponent: 0)
            self.searchCategory(self.categoryList[selectedRow])
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        
        view.addSubview(alert.view)
        alert.view.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
        }
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func searchCategory(_ selectedCategory: String) {
        filteredList.removeAll()
        restaurantList.forEach {
            if $0.category == selectedCategory { filteredList.append($0) }
        }
        configureAnnotation(.filteredRestaurant)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        navigationItem.title = categoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        40
    }
}
