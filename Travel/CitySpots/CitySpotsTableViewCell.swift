//
//  CitySpotsTableViewCell.swift
//  Travel
//
//  Created by NERO on 5/29/24.
//

import UIKit

class CitySpotsTableViewCell: UITableViewCell {
    static let identifier = "CitySpotsTableViewCell"
    
    @IBOutlet var spotTitleLabel: UILabel!
    @IBOutlet var spotDescriptionLabel: UILabel!
    @IBOutlet var starImageViewList: [UIImageView]!
    @IBOutlet var spotTitleDescriptionLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
