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
        configureUI()
        configureButtonUI()
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
    
    func configureUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        
        descriptionLabel.textColor = .systemGray
        descriptionLabel.font = .systemFont(ofSize: 17, weight: .regular)
        descriptionLabel.numberOfLines = 0
        
        bottomView.backgroundColor = .systemGray6
        for borderView in [bottomView, reviewView] {
            borderView!.layer.cornerRadius = 18
            borderView!.layer.borderColor = UIColor(named: "AdBlue")?.cgColor
            borderView!.layer.borderWidth = 1.5
        }
        
        starImage.image = UIImages.fillStarImage
        starImage.tintColor = .systemYellow
        
        gradeLabel.font = .systemFont(ofSize: 13, weight: .regular)
        gradeLabel.textColor = .systemGray2
        
    }
    
    func configureButtonUI() {
        backButton.tintColor = .red
        backButton.image = .init(systemName: "chevron.backward")
        
        reviewButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        reviewButton.titleLabel?.textColor = .systemIndigo
        
        moreReviewsButton.tintColor = .adBlue
        moreReviewsButton.imageView?.image = .init(systemName: "chevron.forward")
        
        heartButton.setImage(UIImages.fillHeartImage, for: .normal)
        heartButton.tintColor = .heartPink
        
        shareButton.setImage(.init(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .adPurple
    }
}
