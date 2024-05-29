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
    @IBOutlet var spotImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSpotUI()
    }
}

//MARK: - UI Setting
enum UIImages {
    static let fillHeartImage = UIImage(systemName: "heart.fill")
    static let emptyHeartImage = UIImage(systemName: "heart")
    static let halfStarImage = UIImage(systemName: "star.leadinghalf.filled")
    static let fillStarImage = UIImage(systemName: "star.fill")
}

extension CitySpotsTableViewCell {
    func configureSpotUI() {
        spotTitleLabel.font = .boldSystemFont(ofSize: 17)
        spotTitleLabel.textColor = .black
        
        spotDescriptionLabel.font = .systemFont(ofSize: 15)
        spotDescriptionLabel.textColor = .darkGray
        spotDescriptionLabel.textAlignment = .left
        spotDescriptionLabel.numberOfLines = 0
        
        for grade in starImageViewList {
            grade.image = UIImages.fillStarImage
            grade.tintColor = .systemGray5
        }
        
        spotTitleDescriptionLabel.textColor = .lightGray
        spotTitleDescriptionLabel.font = .systemFont(ofSize: 14)
        
        spotImageView.contentMode = .scaleAspectFill
        spotImageView.layer.cornerRadius = 8
        
        heartButton.tintColor = .white
    }
}
