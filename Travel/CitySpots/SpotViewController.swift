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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBarUI()
    }
    
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func configureBarUI() {
        navigationItem.title = "관광지 화면"
        backButton.tintColor = .red
        backButton.image = .init(systemName: "chevron.backward")
    }
}
