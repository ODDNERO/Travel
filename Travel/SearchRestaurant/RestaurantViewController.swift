//
//  RestaurantViewController.swift
//  Travel
//
//  Created by NERO on 5/27/24.
//

import UIKit
import Kingfisher

class RestaurantViewController: UIViewController {
    @IBOutlet var restaurantSearchBar: UISearchBar!
    @IBOutlet var restaurantTableView: UITableView!
    
    var restaurantList = RestaurantInfo.restaurantList
    var filteredList: [Restaurant] = [] {
        didSet {
            restaurantTableView.reloadData()
        }
    }

        override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureBarView()
    }
    
    func configureTableView() {
        restaurantTableView.rowHeight = 150
        
        let xib = UINib(nibName: RestaurantTableViewCell.identifier, bundle: nil)
        restaurantTableView.register(xib, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
        
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        restaurantSearchBar.delegate = self
    }
}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
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
    }
    
    @objc func allFoodButtonClicked() {
        filteredList = restaurantList
    }
}
