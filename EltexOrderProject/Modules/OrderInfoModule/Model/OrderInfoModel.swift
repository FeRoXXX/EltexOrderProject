//
//  OrderInfoViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 17.10.2024.
//

import Foundation

struct Order {

    struct Promocode {

        let title: String
        let percent: Int
        let endDate: Date?
        let info: String?
        let active: Bool
    }

    struct Product {
        let price: Double
        let title: String
    }
    
    var screenTitle: String
    var promocodes: [Promocode]
    var availableForActive: [Promocode]
    let products: [Product]
    let paymentDiscount: Double?
    let baseDiscount: Double?
}
