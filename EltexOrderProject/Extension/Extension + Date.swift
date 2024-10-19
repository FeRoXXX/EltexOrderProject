//
//  Extension + Date.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 19.10.2024.
//

import Foundation

extension Date {
    //MARK: - Date to string + formatting function
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let yearOfDate = calendar.component(.year, from: self)

        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        dateFormatter.dateFormat = "d MMMM"
        let dayMonthString = dateFormatter.string(from: self)

        if currentYear == yearOfDate {
            return "По \(dayMonthString)"
        } else {
            dateFormatter.dateFormat = "d MMMM yyyy"
            let fullDateString = dateFormatter.string(from: self)
            return "По \(fullDateString) года"
        }
    }
}
