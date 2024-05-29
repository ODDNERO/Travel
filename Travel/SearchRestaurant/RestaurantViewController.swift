//
//  RestaurantViewController.swift
//  Travel
//
//  Created by NERO on 5/27/24.
//

import UIKit
import Kingfisher

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet var restaurantSearchBar: UISearchBar!
    @IBOutlet var restaurantTableView: UITableView!
    
    let restaurantList = RestaurantInfo.restaurantList
    var filteredList: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantTableView.rowHeight = 150
        
        let xib = UINib(nibName: RestaurantTableViewCell.identifier, bundle: nil)
        restaurantTableView.register(xib, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
        
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        restaurantSearchBar.delegate = self
        
        configureBarView()
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell
        
        let data = filteredList[indexPath.row]
        cell.configureRestaurantCell(data: data)
        
        return cell
    }
}

// MARK: - UI Setting
extension RestaurantViewController {
    func configureBarView() {
        navigationItem.title = "식당 🔍"
        
        let koreanFood = UIBarButtonItem(title: "한식", style: .plain, target: self, action: #selector(koreanFoodButtonClicked))
        koreanFood.tintColor = .red
        
        let allFood = UIBarButtonItem(title: "전체", style: .plain, target: self, action: #selector(allFoodButtonClicked))
        navigationItem.leftBarButtonItems = [koreanFood, allFood]
        allFood.tintColor = .black
    }
    
    @objc func koreanFoodButtonClicked() {
        var koreanFood: [Restaurant] = []
        
        for restaurant in restaurantList {
            if restaurant.category == "한식" {
                koreanFood.append(restaurant)
            }
        }
        
        filteredList = koreanFood
        restaurantTableView.reloadData()
    }
    
    @objc func allFoodButtonClicked() {
        filteredList = restaurantList
        restaurantTableView.reloadData()
    }
}
