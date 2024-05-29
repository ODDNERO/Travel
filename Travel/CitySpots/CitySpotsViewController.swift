//
//  CitySpotsViewController.swift
//  Travel
//
//  Created by NERO on 5/28/24.
//

import UIKit
import Kingfisher

class CitySpotsViewController: UIViewController {
    @IBOutlet var citySpotsTableView: UITableView!
    
    let citySpotList = CitySpotInfo.citySpotList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
    }
    
    func configureTableView() {
        citySpotsTableView.rowHeight = 150
        
        let xib = UINib(nibName: RestaurantTableViewCell.identifier, bundle: nil)
        citySpotsTableView.register(xib, forCellReuseIdentifier: CitySpotsTableViewCell.identifier)
        
        citySpotsTableView.delegate = self
        citySpotsTableView.dataSource = self
    }
}

extension CitySpotsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if citySpotList[indexPath.row].ad == true {
            return 92
        } else {
            return 154
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        citySpotList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

