//
//  RestaurantMapViewController.swift
//  Travel
//
//  Created by NERO on 6/19/24.
//

import UIKit
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
    
    let pickerView = UIPickerView()
    let categoryList = ["한식", "카페", "중식", "분식", "일식", "경양식", "양식"]
    var restaurantList = RestaurantInfo.restaurantList
    var filteredList: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureAnnotation(.allRestaurant)
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

extension RestaurantMapViewController {
    func configureMapView(latitude: Double, longitude: Double) {
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 700, longitudinalMeters: 700)
    }
    
    func configureAnnotation(_ location: LocationCategory) {
        mapView.removeAnnotations(mapView.annotations)
        
        switch location {
        case .preset:
            addAnnotaion(list: nil, latitude: 37.517474, longitude: 126.907357, title: "🌱")
        case .user:
            print("user")
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
}

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
