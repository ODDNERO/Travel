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
    
    var citySpotList = CitySpotInfo.citySpotList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
        configureTableView()
    }
    
    func configureTableView() {
        citySpotsTableView.rowHeight = 150
        
        for cellIdentifier in [CitySpotsTableViewCell.identifier, AdTableViewCell.identifier] {
            let xib = UINib(nibName: cellIdentifier, bundle: nil)
            citySpotsTableView.register(xib, forCellReuseIdentifier: cellIdentifier)
        }
        
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
        let data = citySpotList[indexPath.row]
        
        if data.ad == true {
            let adCell = tableView.dequeueReusableCell(
                withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            adCell.configureAdCell(data: data)
            return adCell
        } else {
            let citySpotCell = tableView.dequeueReusableCell(
                withIdentifier: CitySpotsTableViewCell.identifier, for: indexPath) as! CitySpotsTableViewCell
            citySpotCell.configureSpotCell(data: data)
            
            citySpotCell.heartButton.tag = indexPath.row
            citySpotCell.heartButton.addTarget(self, action: #selector(heartButtonClicked), for: .touchUpInside)
            return citySpotCell
        }
    }
    
    @objc func heartButtonClicked(sender: UIButton) {
        citySpotList[sender.tag].like?.toggle()
        citySpotsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "CitySpots", bundle: nil)
        let data = citySpotList[indexPath.row]
        
        if data.ad == true {
            let adViewController = storyboard.instantiateViewController(withIdentifier: AdViewController.identifier) as! AdViewController
            navigationController?.modalPresentationStyle = .fullScreen
            present(adViewController, animated: true, completion: nil)
        } else {
            let spotViewController = storyboard.instantiateViewController(withIdentifier: SpotViewController.identifier) as! SpotViewController
            navigationController?.pushViewController(spotViewController, animated: true)
        }
    }
}
