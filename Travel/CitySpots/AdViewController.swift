//
//  AdViewController.swift
//  Travel
//
//  Created by NERO on 5/30/24.
//

import UIKit

class AdViewController: UIViewController {
    static let identifier = "AdViewController"
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var closeButton: UIBarButtonItem!
    
    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var arrowLabel: UILabel!
    @IBOutlet var hurryUpButton: UIButton!
    
    var data: CitySpot?
    var cell: AdTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adTitleLabel.text = data?.title
    }
    
    @IBAction func closeButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
