//
//  TravelMagazineTableViewCell.swift
//  Travel
//
//  Created by NERO on 5/27/24.
//

import UIKit

class TravelMagazineTableViewCell: UITableViewCell {
    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var magazineTitleLabel: UILabel!
    @IBOutlet var magazineSubtitleLabel: UILabel!
    @IBOutlet var magazineDateLabel: UILabel!
    
    func configureCell(data: Magazine) {
        let cellImage: String = data.photoURL
        let cellImageURL = URL(string: cellImage)
        magazineImageView.kf.setImage(with: cellImageURL)
        
        magazineTitleLabel.text = data.title
        magazineSubtitleLabel.text = data.subtitle
        
        let cellDate = DateFormatter().convertDateString(inputDate: data.date)
        magazineDateLabel.text = cellDate
    }
}

