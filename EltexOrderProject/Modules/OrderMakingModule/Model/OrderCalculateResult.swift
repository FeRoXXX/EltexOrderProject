//
//  OrderCalculateResult.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 14.12.2024.
//

import Foundation
import SwiftUI

class OrderCalculateResult: ObservableObject {
    @Published var numberOfProducts: String
    @Published var totalPrice: String
    @Published var totalDiscount: String
    @Published var totalPaymentMethod: String
    @Published var totalPromoCode: String
    @Published var totalResultPrice: String
    
    init(numberOfProducts: String,
         totalPrice: String,
         totalDiscount: String,
         totalPaymentMethod: String,
         totalPromoCode: String,
         totalResultPrice: String) {
        self.numberOfProducts = numberOfProducts
        self.totalPrice = totalPrice
        self.totalDiscount = totalDiscount
        self.totalPaymentMethod = totalPaymentMethod
        self.totalPromoCode = totalPromoCode
        self.totalResultPrice = totalResultPrice
    }
}
