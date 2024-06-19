//
//  ReuseldentifierProtocol.swift
//  Travel
//
//  Created by NERO on 6/1/24.
//

import UIKit

protocol ReuseldentifierProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReuseldentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseldentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
