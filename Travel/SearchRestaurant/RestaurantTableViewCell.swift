//
//  RestaurantTableViewCell.swift
//  Travel
//
//  Created by NERO on 5/27/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    static let identifier = "RestaurantTableViewCell"
    
    @IBOutlet var foodCategotyButton: UIButton!
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantAddressLabel: UILabel!
    @IBOutlet var restaurantPriceLabel: UILabel!
    @IBOutlet var restaurantContactLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
