//
//  Extension + Double.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 19.10.2024.
//

import Foundation

extension Double {
    
    //MARK: - Double to string with formatting
    func formatPrice() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = self.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            return "-\(formattedNumber) ₽"
        } else {
            return "-\(self) ₽"
        }
    }
    
    func formatPriceWithoutDegree() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = self.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            return "\(formattedNumber) ₽"
        } else {
            return "\(self) ₽"
        }
    }
}
