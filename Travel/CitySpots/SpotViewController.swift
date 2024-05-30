//
//  SpotViewController.swift
//  Travel
//
//  Created by NERO on 5/30/24.
//

import UIKit

class SpotViewController: UIViewController {
    static let identifier = "SpotViewController"
    
    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var bottomView: UIView!
    @IBOutlet var reviewButton: UIButton!
    @IBOutlet var starImage: UIImageView!
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var reviewView: UIView!
    @IBOutlet var moreReviewsButton: UIButton!
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    
    var data: CitySpot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
    }
    
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func configureData() {
        navigationItem.title = data?.title
        if let image = data?.spotImage {
            let imageURL = URL(string: image)
            imageView.kf.setImage(with: imageURL)
        }
        descriptionLabel.text = data?.description
        
        if let grade = data?.grade {
            gradeLabel.text = String(grade)
        }
        
        let heartImage = data?.like == true ? UIImages.fillHeartImage : UIImages.emptyHeartImage
        heartButton.setImage(heartImage, for: .normal)
    }
}
