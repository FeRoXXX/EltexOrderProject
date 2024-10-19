//
//  Extension + String.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 19.10.2024.
//

import Foundation

extension String {
    
    //MARK: - String to double with separators
    func toDouble() -> Double? {
        let cleanedString = self.replacingOccurrences(of: " ₽", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let number = numberFormatter.number(from: cleanedString) {
            return number.doubleValue
        } else {
            return nil
        }
    }
}
