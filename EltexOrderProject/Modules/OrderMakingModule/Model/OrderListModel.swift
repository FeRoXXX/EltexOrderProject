//
//  OrderListModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import Foundation
import SwiftUI

struct OrderListModel: Identifiable {
    var type: Types
    var id = UUID()
    
    enum Types {
        case order([OrderModel])
        case payment([PaymentMethod])
        case promoCode([PromoCode])
    }
}

class PaymentMethod: Identifiable, ObservableObject {
    var image: String
    var title: String
    var discount: Int
    var sberScores: Int?
    var description: String
    @Published var isActive: Bool = false
    var id = UUID()
    
    init(image: String, title: String, discount: Int = 0, sberScores: Int? = nil, description: String, isActive: Bool = false) {
        self.image = image
        self.title = title
        self.discount = discount
        self.sberScores = sberScores
        self.description = description
        self.isActive = isActive
    }
}

class PromoCode: Identifiable, ObservableObject {
    var title: String
    var date: String
    var description: String?
    var percent: Int
    @Published var isActive: Bool
    var id = UUID()
    
    init(title: String, date: String, description: String? = nil, percent: Int, isActive: Bool = false) {
        self.title = title
        self.date = date
        self.description = description
        self.percent = percent
        self.isActive = isActive
    }
}

class OrderModel: Identifiable {
    var imageURL: URL
    var productName: String
    var productCount: Int
    var size: Int?
    var price: Double
    var discount: Int
    var discountPrice: Double = 0.0
    var productPriceByCount: Double = 0.0
    var id = UUID()
    
    init(imageURL: URL, productName: String, productCount: Int, size: Int? = nil, price: Double, discount: Int) {
        self.imageURL = imageURL
        self.productName = productName
        self.productCount = productCount
        self.size = size
        self.price = price
        self.discount = discount
        calculatePriceByProductCount()
        calculateDiscountPrice()
    }
    
    func calculateDiscountPrice() {
        let discountPercent = Double(discount) / 100
        discountPrice = productPriceByCount - productPriceByCount * discountPercent
    }
    
    func calculatePriceByProductCount() {
        productPriceByCount = price * Double(productCount)
    }
}
