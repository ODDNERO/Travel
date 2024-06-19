//
//  RestaurantTableViewCell.swift
//  Travel
//
//  Created by NERO on 5/27/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet var foodCategotyButton: UIButton!
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantAddressLabel: UILabel!
    @IBOutlet var restaurantPriceLabel: UILabel!
    @IBOutlet var restaurantContactLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        configureRestaurantUI()
    }
    
    func configureRestaurantCell(data: Restaurant) {
        let cellImage: String = data.image
        let cellImageURL = URL(string: cellImage)
        restaurantImageView.kf.setImage(with: cellImageURL)
        
        foodCategotyButton.setTitle(data.category, for: .normal)
        restaurantNameLabel.text = data.name
        restaurantAddressLabel.text = data.address
        restaurantPriceLabel.text = data.price.formatted() + "원"
        restaurantContactLabel.text = data.phoneNumber
        
        let heartImage = data.like == true ? UIImages.fillHeart : UIImages.emptyHeart
        heartButton.setImage(heartImage, for: .normal)
    }
    
    func configureRestaurantUI() {
        foodCategotyButton.backgroundColor = .adYellow
        foodCategotyButton.tintColor = .red
        foodCategotyButton.layer.cornerRadius = 10
        foodCategotyButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        
        restaurantImageView.contentMode = .scaleAspectFill
        restaurantImageView.layer.cornerRadius = 15
        
        restaurantNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        restaurantNameLabel.textColor = .black
        restaurantNameLabel.numberOfLines = 0
        
        restaurantAddressLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        restaurantAddressLabel.textColor = .black
        restaurantNameLabel.numberOfLines = 0
        
        restaurantPriceLabel.font = .systemFont(ofSize: 13, weight: .regular)
        restaurantPriceLabel.textColor = .lightGray
        
        heartButton.tintColor = .heartPink
    }
}
