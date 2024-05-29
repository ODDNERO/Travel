//
//  AdTableViewCell.swift
//  Travel
//
//  Created by NERO on 5/29/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    @IBOutlet var adView: UIView!
    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var adButton: UIButton!
    
    let randomAdViewColor = ["AdBlue", "AdGreen", "AdPink", "AdPurple", "AdYellow"].randomElement()!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAdUI()
    }
    
    func configureAdCell(data: CitySpot) {
        adTitleLabel.text = data.title
        adButton.setTitle("AD", for: .normal)
    }
    
    func configureAdUI() {
        adView.backgroundColor = UIColor(named: randomAdViewColor)
        adView.layer.cornerRadius = 10
        
        adTitleLabel.font = .boldSystemFont(ofSize: 17)
        adTitleLabel.textAlignment = .center
 
        adButton.setTitleColor(.black, for: .normal)
        adButton.backgroundColor = .white
        adButton.layer.cornerRadius = 5
    }
}
