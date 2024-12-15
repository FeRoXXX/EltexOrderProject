//
//  Extension+Int.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import Foundation

extension Int {
    
    //MARK: - Formatted discount
    
    func formattedDiscount() -> String {
        return "-\(self)%"
    }
    
    //MARK: - Formatted sber scores
    
    func formattedSberScores() -> String {
        return "+\(self)%"
    }
    
    //MARK: - Formatted size
    
    func formattedSize() -> String {
        return "• Размер: \(self)"
    }
    
    //MARK: - Formatted count
    
    func formattedCount() -> String {
        return "\(self) шт."
    }
    
    //MARK: - Formatted count of product
    
    func formatPrice() -> String {
        let suffix: String
        let lastDigit = self % 10
        let lastTwoDigits = self % 100
        
        if lastTwoDigits >= 11 && lastTwoDigits <= 14 {
            suffix = "товаров"
        } else {
            switch lastDigit {
            case 1:
                suffix = "товар"
            case 2, 3, 4:
                suffix = "товара"
            default:
                suffix = "товаров"
            }
        }
        
        return "Цена за \(self) \(suffix)"
    }
}
