//
//  OrderMakingViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import Foundation
import Combine

final class OrderMakingViewModel: ObservableObject {
    
    //MARK: - Private properties
    
    @Published var listData: [OrderListModel] = []
    
    init() {
        setupFirstData()
    }
}

//MARK: - Private extension

private extension OrderMakingViewModel {
    
    //MARK: - Setup first data
    
    func setupFirstData() {
        listData = [
            .init(type: .order([
                .init(imageURL: "ringFirst",
                      productName: "Золотое плоское обручальное кольцо 4 мм",
                      productCount: 1,
                      size: 17,
                      price: 32217,
                      discount: 40),
                .init(imageURL: "ringSecond",
                      productName: "Золотое плоское обручальное кольцо 4 мм",
                      productCount: 3,
                      size: 13,
                      price: 30012,
                      discount: 20)
            ])),
            .init(type: .payment([
                .init(image: "sber",
                      title: "SberPay",
                      discount: 5,
                      sberScores: 5,
                      description: "Через приложение СберБанк"),
                .init(image: "bankCard",
                      title: "Банковской картой",
                      discount: 5,
                      description: "Visa, Master Card, МИР"),
                .init(image: "ypay",
                      title: "Яндекс Пэй со Сплитом",
                      discount: 5,
                      description: "Оплата частями"),
                .init(image: "tinkoff",
                      title: "Рассрочка Тинькофф",
                      discount: 5,
                      description: "На 3 месяца без переплат"),
                .init(image: "tinkoff-pay",
                      title: "Tinkoff Pay",
                      discount: 5,
                      description: "Через приложение Тинькофф"),
                .init(image: "wallet",
                      title: "Оплата при получении",
                      discount: 5,
                      description: "Наличными или картой"),
            ])),
            .init(type: .promoCode([
                .init(title: "SECRETCODE",
                      date: "По 31 марта",
                      percent: 5)
            ]))
        ]
    }
}
