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
    @Published var priceAfterDiscount: OrderCalculateResult = .init(numberOfProducts: 0.formatPrice(),
                                                                    totalPrice: "0",
                                                                    totalDiscount: "0",
                                                                    totalPaymentMethod: "0",
                                                                    totalPromoCode: "0",
                                                                    totalResultPrice: "0")
    
    init() {
        setupFirstData()
        calculatePrice()
    }
}

//MARK: - Private extension

private extension OrderMakingViewModel {
    
    //MARK: - Setup first data
    
    func setupFirstData() {
        listData = [
            .init(type: .order([
                .init(imageURL: URL(string: "https://t3.ftcdn.net/jpg/05/64/35/80/360_F_564358021_KBRaemBSj9FGjZlupRQsloTJIMo1MATC.jpg")!,
                      productName: "Золотое плоское обручальное кольцо 4 мм",
                      productCount: 1,
                      size: 17,
                      price: 32217,
                      discount: 40),
                .init(imageURL: URL(string: "https://www.candere.com/media/jewellery/images/GR00103__1.jpeg")!,
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
                      description: "Visa, Master Card, МИР",
                      isActive: true),
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
                      description: "Наличными или картой"),
            ])),
            .init(type: .promoCode([
                .init(title: "SECRETCODE",
                      date: "По 31 марта",
                      percent: 5),
                .init(title: "HELLO",
                      date: "По 31 марта",
                      percent: 5),
                .init(title: "VESNA23",
                      date: "По 31 марта",
                      percent: 5),
                .init(title: "4300162112534",
                      date: "По 31 марта",
                      percent: 5),
                
            ]))
        ]
    }
}

//MARK: - Public extension

extension OrderMakingViewModel {
    
    //MARK: - Active payment method
    
    func setActivePaymentMethod(_ selectedMethod: PaymentMethod) {
        if let index = listData.firstIndex(where: {
            if case .payment(let paymentList) = $0.type {
                return paymentList.contains(where: { $0.id == selectedMethod.id })
            }
            return false
        }) {
            if case .payment(let paymentList) = listData[index].type {
                for method in paymentList {
                    method.isActive = (method.id == selectedMethod.id)
                }
            }
        }
    }
    
    func calculatePrice(promocode: PromoCode? = nil) {
        var orderList: [OrderModel] = []
        var paymentMethod: PaymentMethod?
        var promocodes: [PromoCode] = []
        listData.forEach { currentValue in
            switch currentValue.type {
            case .order(let array):
                orderList = array
            case .payment(let array):
                array.forEach { value in
                    if value.isActive {
                        paymentMethod = value
                    }
                }
            case .promoCode(let array):
                array.forEach { value in
                    if value.isActive {
                        promocodes.append(value)
                    }
                }
            }
        }
        
        if let promocode {
            OrderCalculateService.shared.checkPromocode(listArray: &listData, promocode: promocode)
        }
        guard let paymentMethod else { return }
        let calculateResult = OrderCalculateService.shared.calculatePrice(orderList: orderList, paymentMethod: paymentMethod, promocodes: promocodes)
        priceAfterDiscount = OrderCalculateResult(numberOfProducts: calculateResult.numberOfProducts.formatPrice(),
                                                  totalPrice: calculateResult.totalPrice.formatPriceWithoutDegree(),
                                                  totalDiscount: "-\(calculateResult.productDiscount.formatPriceWithoutDegree())",
                                                  totalPaymentMethod: "-\(calculateResult.paymentDiscount.formatPriceWithoutDegree())",
                                                  totalPromoCode: "-\(calculateResult.promoCodeDiscount.formatPriceWithoutDegree())",
                                                  totalResultPrice: calculateResult.totalPriceAfterDiscount.formatPriceWithoutDegree())
    }
    
    func hidePromocodes() {
        for (index, element) in listData.enumerated() {
            switch element.type {
            case .promoCode(let array):
                let promocodes = OrderCalculateService.shared.filterPromoCodes(promocodes: array)
                listData[index] = .init(type: .promoCode(promocodes))
            default:
                break
            }
        }
    }
    
    func addNewPromocode(promocode: PromoCode) {
        OrderCalculateService.shared.addNewPromocode(listArray: &listData, promocode: promocode)
        calculatePrice()
    }
}
