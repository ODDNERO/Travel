//
//  UIViewController+.swift
//  Travel
//
//  Created by NERO on 5/30/24.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(title: String?, message: String?, closeButton: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let close = UIAlertAction(title: closeButton, style: .destructive)
    
        alert.addAction(close)
        present(alert, animated: true)
    }
}
