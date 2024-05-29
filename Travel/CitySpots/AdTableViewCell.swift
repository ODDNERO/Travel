//
//  AdTableViewCell.swift
//  Travel
//
//  Created by NERO on 5/29/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    static let identifier = "AdTableViewCell"
    
    @IBOutlet var adView: UIView!
    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var adButton: UIButton!
    
    var adViewColors = ["AdBlue", "AdGreen", "AdPink", "AdPurple", "AdYellow"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAdUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        adView.backgroundColor = UIColor(named: adViewColors.randomElement()!)
    }
    
    func configureAdCell(data: CitySpot) {
        adTitleLabel.text = data.title
        adButton.setTitle("AD", for: .normal)
    }
    
    func configureAdUI() {
        adView.backgroundColor = UIColor(named: adViewColors.randomElement()!)
        adView.layer.cornerRadius = 10
        
        adTitleLabel.font = .boldSystemFont(ofSize: 17)
        adTitleLabel.textAlignment = .center
        
        adButton.setTitleColor(.black, for: .normal)
        adButton.backgroundColor = .white
        adButton.layer.cornerRadius = 8
        adButton.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        adButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        adButton.titleLabel?.textAlignment = .center
    }
}
