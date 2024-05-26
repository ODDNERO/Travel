//
//  TravelMagazineTableViewController.swift
//  Travel
//
//  Created by NERO on 5/27/24.
//

import UIKit
import Kingfisher

class TravelMagazineTableViewController: UITableViewController {
    var magazineInfo = MagazineInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 436
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineInfo.magazineList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "magazineCell", for: indexPath) as! TravelMagazineTableViewCell
        
        let cellImage: String = magazineInfo.magazineList[indexPath.row].photoURL
        let cellImageURL = URL(string: cellImage)
        cell.magazineImageView.kf.setImage(with: cellImageURL)
        
        return cell
    }
}
