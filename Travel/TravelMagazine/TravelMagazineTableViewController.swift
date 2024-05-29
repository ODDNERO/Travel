//
//  TravelMagazineTableViewController.swift
//  Travel
//
//  Created by NERO on 5/27/24.
//

import UIKit
import Kingfisher

class TravelMagazineTableViewController: UITableViewController {
    var magazineList = MagazineInfo.magazineList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "여행 매거진"
        tableView.rowHeight = 436
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "magazineCell", for: indexPath) as! TravelMagazineTableViewCell
        
        cell.configureCell(data: magazineList[indexPath.row])
        
        return cell
    }
}



