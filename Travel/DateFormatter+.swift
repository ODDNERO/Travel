//
//  DateFormatter+.swift
//  Travel
//
//  Created by NERO on 5/27/24.
//

import Foundation

extension DateFormatter {
    func convertDateString(inputDate: String) -> String? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyMMdd"
        guard let formattedDate = dateFormatter.date(from: inputDate) else {
            return nil
        }

        dateFormatter.dateFormat = "yy년 MM월 dd일"
        let outputDate = dateFormatter.string(from: formattedDate)
        
        return outputDate
    }
}
