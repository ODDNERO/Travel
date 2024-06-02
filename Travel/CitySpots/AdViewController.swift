//
//  AdViewController.swift
//  Travel
//
//  Created by NERO on 5/30/24.
//

import UIKit

class AdViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var closeButton: UIBarButtonItem!
    
    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var arrowLabel: UILabel!
    @IBOutlet var hurryUpButton: UIButton!
    
    var data: CitySpot?
    var cell: AdTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @IBAction func closeButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureUI() {
        adTitleLabel.text = data?.title
        closeButton.tintColor = .systemIndigo
        closeButton.image = UIImages.xmarkImage
        
        backgroundView.backgroundColor = cell?.adView.backgroundColor
        
        adTitleLabel.backgroundColor = .white
        adTitleLabel.layer.cornerRadius = 15
        adTitleLabel.clipsToBounds = true
        adTitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        adTitleLabel.textAlignment = .center
        adTitleLabel.textColor = .black
        
        arrowLabel.text = "⬇️⬇️⬇️⬇️⬇️"
        arrowLabel.font = .boldSystemFont(ofSize: 30)
        arrowLabel.textAlignment = .center
        
        hurryUpButton.setTitle("서두르세요!!", for: .normal)
        hurryUpButton.setTitleColor(.red, for: .normal)
        hurryUpButton.setTitleColor(.blue, for: .highlighted)
        hurryUpButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .heavy)
    }
}
