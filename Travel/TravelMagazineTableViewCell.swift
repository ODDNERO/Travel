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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellStyle()
    }
    
    func configureCellStyle() {
        magazineImageView.contentMode = .scaleAspectFill
        magazineImageView.layer.cornerRadius = 15
        
        magazineTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        magazineTitleLabel.textColor = .black
        magazineTitleLabel.numberOfLines = 0
        
        magazineSubtitleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        magazineSubtitleLabel.textColor = .lightGray
        
        magazineDateLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        magazineDateLabel.textColor = .lightGray
        magazineDateLabel.textAlignment = .right
    }
    
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

