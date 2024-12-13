//
//  OrderListModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import Foundation

struct OrderListModel: Identifiable {
    let type: Types
    var id = UUID()
    
    enum Types {
        case order([OrderModel])
        case payment([PaymentMethod])
        case promoCode([PromoCode])
    }
}

class PaymentMethod: Identifiable {
    var image: String
    var title: String
    var discount: Int
    var sberScores: Int?
    var description: String
    var id = UUID()
    
    init(image: String, title: String, discount: Int, sberScores: Int? = nil, description: String) {
        self.image = image
        self.title = title
        self.discount = discount
        self.sberScores = sberScores
        self.description = description
    }
}

class PromoCode: Identifiable {
    var title: String
    var date: String
    var description: String?
    var percent: Int
    var id = UUID()
    
    init(title: String, date: String, description: String? = nil, percent: Int) {
        self.title = title
        self.date = date
        self.description = description
        self.percent = percent
    }
}

class OrderModel: Identifiable {
    var imageURL: String
    var productName: String
    var productCount: Int
    var size: Int?
    var price: Double
    var discount: Int
    var discountPrice: Double = 0.0
    var productPriceByCount: Double = 0.0
    var id = UUID()
    
    init(imageURL: String, productName: String, productCount: Int, size: Int? = nil, price: Double, discount: Int) {
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
