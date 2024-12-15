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
        let decimalValue = NSDecimalNumber(value: self)
        let roundedValue = decimalValue.rounding(accordingToBehavior: NSDecimalNumberHandler(
            roundingMode: .plain, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false
        ))
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = roundedValue.doubleValue.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        
        if let formattedNumber = numberFormatter.string(from: roundedValue) {
            return "\(formattedNumber) ₽"
        } else {
            return "\(roundedValue) ₽"
        }
    }
}
