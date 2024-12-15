//
//  OrderCancellationViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 06.12.2024.
//

import Foundation
import Combine

final class OrderCancellationViewModel: ObservableObject {
    
    //MARK: - Public properties
    
    @Published var data: [OrderCancellationListModel] = [
        .init(type: .checkRow("Не подходит дата получения")),
        .init(type: .checkRow("Часть товаров из заказа была отменена")),
        .init(type: .checkRow("Не получилось применить скидку")),
        .init(type: .checkRow("Хочу изменить заказ и оформить заново")),
        .init(type: .checkRow("Нашелся товар дешевле")),
        .init(type: .checkRow("Другое", true)),
        .init(type: .screenDescription("Обычно деньги сразу возвращаются на карту. В некоторых случаях это может занять до 3 рабочих дней.")),
        .init(type: .cancelButton("Отменить заказ"))
    ]
    
    //MARK: - Cancel order
    
    func cancelOrder() {
        
    }
    
    //MARK: - Show error
    
    func showErrorCell() {
        if data.contains(where: { value in
            if value.type.caseType == OrderCancellationListModel.Types.error().caseType {
                return true
            }
            return false
        }) {
            return
        } else {
            data.insert(.init(type: .error("Пожалуйста, выберите причину")), at: 0)
        }
    }
    
    //MARK: - Hide error
    
    func hideErrorCell() {
        data.removeAll { value in
            if value.type.caseType == OrderCancellationListModel.Types.error().caseType {
                return true
            }
            return false
        }
    }
    
    //MARK: - Prepare problem
    
    func prepareProblemDescription(isOther: Bool) {
        if isOther {
            if data.contains(where: { value in
                if value.type.caseType == OrderCancellationListModel.Types.problemDescriptionTextField("").caseType {
                    return true
                }
                return false
            }) {
                return
            } else {
                data.insert(.init(type: .problemDescriptionTextField("Опишите проблему")), at: data.count - 2)
            }
        } else {
            data.removeAll { value in
                if value.type.caseType == OrderCancellationListModel.Types.problemDescriptionTextField("").caseType {
                    return true
                }
                return false
            }
        }
    }
}
