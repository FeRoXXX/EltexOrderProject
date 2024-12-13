//
//  Extension+Double.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import Foundation


extension Double {
    
    //MARK: - Price formatter
    
    func calculatePrice() -> String {
        let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "₽"
            formatter.currencyGroupingSeparator = " "
            formatter.currencyDecimalSeparator = ","
            formatter.locale = Locale(identifier: "ru_RU")
            
            return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
