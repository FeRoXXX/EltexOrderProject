//
//  OrderResultViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 15.12.2024.
//

import Foundation
import Combine

final class OrderResultViewModel: ObservableObject {
    
    //MARK: - Public properties
    
    @Published var viewData: OrderResultModel
    
    //MARK: - Initialization
    
    init() {
        viewData = .init(image: "bagSuccess", result: "Спасибо за заказ!", description: "Заказ успешно оформлен. Вы можете отслеживать его статус в личном кабинете.", buttonText: "Продолжить покупки", statusButton: "Статус заказа")
        viewData = getOrderResult()
    }
}

//MARK: - Private extension

private extension OrderResultViewModel {
    
    //MARK: - Get result
    
    func getOrderResult() -> OrderResultModel {
        let arrayOfResults: [OrderResultModel] = [
            .init(image: "bagSuccess", result: "Спасибо за заказ!", description: "Заказ успешно оформлен. Вы можете отслеживать его статус в личном кабинете.", buttonText: "Продолжить покупки", statusButton: "Статус заказа"),
            .init(image: "bagSuccess", result: "Спасибо за заказ!", description: "Обратите внимание, что у неоплаченных заказов ограниченный срок хранения", buttonText: "Продолжить покупки", statusButton: "Статус заказа"),
            .init(image: "paymentError", result: "Оплата не прошла", description: "Возможно, были введены неверные данные или произошла ошибка на стороне платежной системы", buttonText: "Попробовать еще раз"),
            .init(image: "bagError", result: "Что-то пошло не так...", description: "К сожалению, ваш заказ не был создан", buttonText: "На главную")
            ]
        let randomElement = arrayOfResults.randomElement() ?? .init(image: "bagSuccess", result: "Спасибо за заказ!", description: "Заказ успешно оформлен. Вы можете отслеживать его статус в личном кабинете.", buttonText: "Продолжить покупки", statusButton: "Статус заказа")
        return randomElement
    }
}
