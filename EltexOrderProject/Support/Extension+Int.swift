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
}
