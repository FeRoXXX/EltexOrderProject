//
//  OrderInfoViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 18.10.2024.
//

import Foundation

final class OrderInfoViewModel {
    
    private var orderList: [Order]?
    private var orderListFormatted: [OrderInfoTableViewModel] {
        didSet {
            delegate?.cellDidChange(orderListFormatted)
        }
    }
    
    weak var delegate: OrderInfoViewModelDelegate? {
        didSet {
            delegate?.cellDidChange(orderListFormatted)
        }
    }
    
    init() {
        orderListFormatted = [.init(type: .topItem(.init(title: "Промокоды", info: "На один товар можно применить только один промокод", buttonTitle: "Применить промокод"))),
                              .init(type: .promo(.init(title: "HELLO", percent: 5, date: "По 31 марта", additionalInformation: "Промокод действует на первый заказ в приложении", isToggle: false))),
                              .init(type: .promo(.init(title: "VESNA23", percent: 5, date: "По 31 марта", additionalInformation: "Промокод действует для заказов от 30 000 ₽", isToggle: false))),
                              .init(type: .promo(.init(title: "4300162112534", percent: 5, date: "По 31 марта", additionalInformation: nil, isToggle: false))),
                              .init(type: .promo(.init(title: "4300162112534", percent: 5, date: "По 31 марта", additionalInformation: nil, isToggle: true))),
                              .init(type: .promo(.init(title: "4300162112534", percent: 5, date: "По 31 марта", additionalInformation: nil, isToggle: false))),
                              .init(type: .hidePromo(.init(title: "Скрыть промокоды"))),
                              .init(type: .bottomItem(.init(generalTitle: "Цена за 2 товара", generalPrice: "25 000 ₽", discountTitle: "Скидки", discountPrice: "-5 000 ₽", promoCodeTitle: "Промокоды", promoCodePrice: "-5 000 ₽", paymentMethodTitle: "Способы оплаты", paymentMethodPrice: "-5 000 ₽", resultTitle: "Итого", resultPrice: "19 000 ₽", nextButtonTitle: "Оформить заказ", userAgreement: "Нажимая кнопку «Оформить заказ»,\nВы соглашаетесь с Условиями оферты")))]
    }
}
