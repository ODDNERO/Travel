//
//  RestaurantViewController.swift
//  Travel
//
//  Created by NERO on 5/27/24.
//

import UIKit
import Kingfisher
import SnapKit

class RestaurantViewController: UIViewController {
    @IBOutlet var restaurantSearchBar: UISearchBar!
    @IBOutlet var restaurantTableView: UITableView!
    let pickerView = UIPickerView()
    
    let categoryList = ["한식", "카페", "중식", "분식", "일식", "경양식", "양식"]
    var restaurantList = RestaurantInfo.restaurantList
    var filteredList: [Restaurant] = [] {
        didSet {
            restaurantTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarView()
        configureTableView()
        allFoodButtonClicked()
    }
}

extension RestaurantViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchList: [Restaurant] = []
        
        for restaurant in restaurantList {
            if restaurant.name.contains(searchBar.text!) || restaurant.category.contains(searchBar.text!) {
                searchList.append(restaurant)
            }
        }
        filteredList = searchList
        
        if searchList.isEmpty {
            presentAlert(title: "⚠️", message: "식당이 검색되지 않았어요", closeButton: "🆇")
        }
    }
    
    func configureBarView() {
        navigationItem.title = "식당 🔍"
        navigationItem.backButtonTitle = ""
        
        let allFood = UIBarButtonItem(title: "전체", style: .plain, target: self, action: #selector(allFoodButtonClicked))
        let category = UIBarButtonItem(title: "분류", style: .plain, target: self, action: #selector(categoryButtonClicked))
        allFood.tintColor = .black
        category.tintColor = .red
        navigationItem.leftBarButtonItems = [allFood, category]
        
        let map = UIBarButtonItem(image: UIImages.map, style: .plain, target: self, action: #selector(mapButtonClicked))
        map.tintColor = .map
        navigationItem.rightBarButtonItem = map
        
        restaurantSearchBar.delegate = self
    }
    
    @objc func allFoodButtonClicked() {
        restaurantSearchBar.text = ""
        restaurantSearchBar.placeholder = "식당 혹은 카테고리를 검색해 보세요!"
        filteredList = restaurantList
    }
    
    @objc func categoryButtonClicked() {
        configureCategoryPicker()
    }
    
    @objc func mapButtonClicked() {
        navigationController?.pushViewController(RestaurantMapViewController(), animated: true)
    }
}

extension RestaurantViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        let alert = UIAlertController(title: "😋 무엇을 먹을까요?", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
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
        restaurantSearchBar.placeholder = categoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        40
    }
}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        restaurantTableView.rowHeight = 150
        let xib = UINib(nibName: RestaurantTableViewCell.identifier, bundle: nil)
        restaurantTableView.register(xib, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell
        let data = filteredList[indexPath.row]
        cell.configureRestaurantCell(data: data)
        
        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(heartButtonClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func heartButtonClicked(sender: UIButton) {
        restaurantList[sender.tag].like.toggle()
        filteredList[sender.tag].like.toggle()
    }
}
