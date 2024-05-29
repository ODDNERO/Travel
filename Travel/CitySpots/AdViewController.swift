//
//  AdViewController.swift
//  Travel
//
//  Created by NERO on 5/30/24.
//

import UIKit

class AdViewController: UIViewController {
    static let identifier = "AdViewController"
    
    @IBOutlet var closeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBarUI()
    }
    
    @IBAction func closeButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureBarUI() {
        navigationItem.title = "광고 화면"
        closeButton.tintColor = .red
        closeButton.image = .init(systemName: "xmark")
    }
}
