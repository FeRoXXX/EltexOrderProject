//
//  OrderCalculateService.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 14.12.2024.
//

import Foundation
import Combine

final class OrderCalculateService {
    
    //MARK: - Private properties
    
    private var allPromoCodes: [PromoCode] = []
    private var isPromocodesHidden: Bool = false
    
    //MARK: - Static properties
    
    static let shared = OrderCalculateService()
    
    //MARK: - Calculate order price
    
    func calculatePrice(orderList: [OrderModel], paymentMethod: PaymentMethod, promocodes: [PromoCode]) -> (numberOfProducts: Int, totalPrice: Double, totalPriceAfterDiscount: Double, productDiscount: Double, paymentDiscount: Double, promoCodeDiscount: Double) {
        let orderTotalWithDiscount = orderList.reduce(0.0) { result, order in
            return result + order.discountPrice
        }
        
        let orderTotal = orderList.reduce(0.0) { result, order in
            return result + order.productPriceByCount
        }
        let productsCount = orderList.reduce(0) { result, order in
            return result + order.productCount
        }
        
        let productDiscount = orderTotal - orderTotalWithDiscount
        
        let paymentDiscount = paymentMethod.discount
        let paymentDiscountAmount = orderTotalWithDiscount * Double(paymentDiscount) / 100
        var totalAfterPaymentDiscount = orderTotalWithDiscount - paymentDiscountAmount
        
        var promoCodeDiscountResult = 0.0
        for promoCode in promocodes {
            let promoDiscountAmount = totalAfterPaymentDiscount * Double(promoCode.percent) / 100
            totalAfterPaymentDiscount -= promoDiscountAmount
            promoCodeDiscountResult += promoDiscountAmount
        }
        
        return (productsCount, orderTotal, totalAfterPaymentDiscount, productDiscount, paymentDiscountAmount, promoCodeDiscountResult)
    }
    
    //MARK: - Filter active promocode
    
    func filterPromoCodes(promocodes: [PromoCode]) -> [PromoCode] {
        if !isPromocodesHidden {
            allPromoCodes = promocodes
            let activePromoCodes = promocodes.filter { $0.isActive }
            let inactivePromoCodes = promocodes.filter { !$0.isActive }
            
            var resultPromoCodes = Array(activePromoCodes.prefix(3))
            
            let remainingCount = 3 - resultPromoCodes.count
            if remainingCount > 0 {
                resultPromoCodes.append(contentsOf: inactivePromoCodes.prefix(remainingCount))
            }
            isPromocodesHidden = !isPromocodesHidden
            return resultPromoCodes
        } else {
            isPromocodesHidden = !isPromocodesHidden
            return allPromoCodes
        }
    }
    
    //MARK: - Check promocode
    
    func checkPromocode(listArray: inout [OrderListModel], promocode: PromoCode) -> String? {
        var activePromocode = 0
        
        listArray.forEach { value in
            switch value.type {
            case .promoCode(let array):
                activePromocode = array.filter { $0.isActive }.count
            default:
                break
            }
        }
        
        if activePromocode >= 3 {
            listArray.forEach { value in
                switch value.type {
                case .promoCode(let array):
                    array.forEach { value in
                        if value.id == promocode.id {
                            value.isActive = false
                        }
                    }
                default:
                    break
                }
            }
            return "Нельзя активировать больше 2х промокодов"
        }
        
        return nil
    }
    
    //MARK: - Add new promocode
    
    func addNewPromocode(listArray: inout [OrderListModel], promocode: PromoCode) -> String? {
        var activePromocodeCount = 1
        listArray.forEach { value in
            switch value.type {
            case .promoCode(let array):
                activePromocodeCount += array.filter { $0.isActive }.count
            default:
                break
            }
        }
        
        if activePromocodeCount >= 3 {
            listArray.forEach { value in
                switch value.type {
                case .promoCode(let array):
                    if let oldestActivePromo = array.first(where: { $0.isActive }) {
                        oldestActivePromo.isActive = false
                    }
                default:
                    break
                }
            }
        }
        
        listArray.enumerated().forEach { index, value in
            switch value.type {
            case .promoCode(var array):
                if !array.contains(where: { $0.id == promocode.id }) {
                    if isPromocodesHidden {
                        promocode.isActive = true
                        allPromoCodes.append(promocode)
                        listArray.remove(at: index)
                        isPromocodesHidden = false
                        listArray.insert(.init(type: .promoCode(filterPromoCodes(promocodes: allPromoCodes))), at: index)
                    } else {
                        promocode.isActive = true
                        array.append(promocode)
                        listArray.remove(at: index)
                        listArray.insert(.init(type: .promoCode(array)), at: index)
                    }
                }
            default:
                break
            }
        }
        
        if activePromocodeCount >= 3 {
            return "Нельзя активировать больше 2х промокодов, последний был отменен"
        }
        
        return nil
    }

}
