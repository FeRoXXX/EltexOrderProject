//
//  OrderInfoViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 18.10.2024.
//

import Foundation

final class OrderInfoViewModel {
    
    //MARK: - Properties
    private var orderList: Order
    private var orderListFormatted: [OrderInfoTableViewModel] {
        didSet {
            var indexes: [IndexPath] = []
            for (index, element) in oldValue.enumerated() {
                switch element.type {
                case .topItem(let oldData):
                    switch orderListFormatted[index].type {
                    case .topItem(let data):
                        if oldData != data {
                            indexes.append(.init(row: index, section: 0))
                        }
                        default:
                            break
                    }
                case .promo(let oldData):
                    switch orderListFormatted[index].type {
                    case .promo(let data):
                        if oldData != data {
                            indexes.append(.init(row: index, section: 0))
                        }
                        default:
                            break
                    }
                case .hidePromo(let oldData):
                    switch orderListFormatted[index].type {
                    case .hidePromo(let data):
                        if oldData != data {
                            indexes.append(.init(row: index, section: 0))
                        }
                        default:
                            break
                    }
                case .bottomItem(let oldData):
                    switch orderListFormatted[index].type {
                    case .bottomItem(let data):
                        if oldData != data {
                            indexes.append(.init(row: index, section: 0))
                        }
                        default:
                            break
                    }
                }
            }
            delegate?.reloadCell(at: indexes, data: orderListFormatted)
        }
    }
    
    private var errorMessage: String = "" {
        didSet {
            delegate?.showAlert(message: errorMessage)
        }
    }
    
    private var title: String = "" {
        didSet {
            delegate?.setTitle(title)
        }
    }
    
    weak var delegate: OrderInfoViewModelDelegate? {
        didSet {
            delegate?.setTitle(title)
            delegate?.cellDidChange(orderListFormatted)
        }
    }
    
    //MARK: - Initialization
    init(orderList: Order) {
        self.orderList = orderList
        orderListFormatted = []
        formattedTopCell()
        orderList.promocodes.forEach {
            formattedPromoCode(promocode: $0)
        }
        formattedHidePromoCode()
        amountPriceFirstInput()
        title = orderList.screenTitle
    }
}

//MARK: - Private extension
private extension OrderInfoViewModel {
    
    //MARK: - Formatted Top cell function
    func formattedTopCell() {
        
        orderListFormatted.append(.init(
            type: .topItem(.init(
                title: TextConstants.OrderInfoModule.TableView.TopItemCell.title.rawValue,
                info: TextConstants.OrderInfoModule.TableView.TopItemCell.info.rawValue,
                buttonTitle: TextConstants.OrderInfoModule.TableView.TopItemCell.buttonTitle.rawValue)))
        )
    }
    
    //MARK: - Formatted promoCode cell function
    func formattedPromoCode(promocode: Order.Promocode) {
        orderListFormatted.append(
            .init(type: .promo(.init(
                title: promocode.title,
                percent: promocode.percent,
                date: promocode.endDate?.formatDate(),
                additionalInformation: promocode.info,
                isToggle: promocode.active,
                toggle: { [weak self] boolValue, id in
                    self?.togglePromocode(boolValue, id)
                }))))
    }
    
    //MARK: - Formatted hide button function
    func formattedHidePromoCode() {
        orderListFormatted.append(.init(type: .hidePromo(.init(
            title: TextConstants.OrderInfoModule.TableView.HidePromoCodeCell.title.rawValue
        ))))
    }
    
    //MARK: - amountPrice in bottom cell
    func amountPrice(_ isOn: Bool, _ id: UUID) {
        if let lastElement = orderListFormatted.last {
            switch lastElement.type {
            case .bottomItem(let bottomItemCell):
                let promocodes = orderListFormatted.filter {
                    switch $0.type {
                    case .promo(let promoCell):
                        return promoCell.isToggle
                    default:
                        return false
                    }
                }
                
                var totalPrice: Double = 0
                var promoCodePrice: Double = 0
                
                orderList.products.forEach { totalPrice += $0.price }
                let totalPriceOutput = totalPrice
                
                let baseDiscount = orderList.baseDiscount ?? 0
                let paymentDiscount = orderList.paymentDiscount ?? 0
                totalPrice -= baseDiscount
                totalPrice -= paymentDiscount
                
                promocodes.forEach {
                    switch $0.type {
                    case .promo(let promoCell):
                        let discountAmount = totalPriceOutput * (Double(promoCell.percent) / 100)
                        totalPrice -= discountAmount
                        promoCodePrice += discountAmount
                    default:
                        break
                    }
                }
                
                if totalPrice < 0 {
                    changeToggle(!isOn, id)
                    amountPrice(!isOn, id)
                    errorMessage = "Цена за 2 промокода не должна быть больше общей суммы товара"
                }
                
                if let index = orderListFormatted.firstIndex(where: { $0.type == .bottomItem(bottomItemCell) }) {
                    var updatedBottomItemCell = bottomItemCell
                    updatedBottomItemCell.promoCodePrice = promoCodePrice.formatPrice()
                    updatedBottomItemCell.resultPrice = totalPrice.formatPriceWithoutDegree()
                    
                    orderListFormatted[index] = OrderInfoTableViewModel(type: .bottomItem(updatedBottomItemCell))
                }
            default:
                amountPriceFirstInput()
            }
        } else {
            amountPriceFirstInput()
        }
    }

    func amountPriceFirstInput() {
        let activePromocodes = orderList.promocodes.filter { $0.active }
        var totalPrice: Double = 0
        var promoCodePrice: Double = 0
        
        orderList.products.forEach { totalPrice += $0.price }
        let totalPriceOutput = totalPrice
        
        let baseDiscount = orderList.baseDiscount ?? 0
        let paymentDiscount = orderList.paymentDiscount ?? 0
        totalPrice -= baseDiscount
        totalPrice -= paymentDiscount
        
        activePromocodes.forEach {
            let discountAmount = totalPriceOutput * (Double($0.percent) / 100)
            totalPrice -= discountAmount
            promoCodePrice += discountAmount
        }
        
        orderListFormatted.append(.init(type: .bottomItem(.init(
            generalTitle: formatPrice(for: orderList.products.count),
            generalPrice: totalPriceOutput.formatPriceWithoutDegree(),
            discountTitle: TextConstants.OrderInfoModule.TableView.BottomItemCell.discountTitle.rawValue,
            discountPrice: orderList.baseDiscount?.formatPrice() ?? "0 ₽",
            promoCodeTitle: TextConstants.OrderInfoModule.TableView.BottomItemCell.promoCodeTitle.rawValue,
            promoCodePrice: promoCodePrice.formatPrice(),
            paymentMethodTitle: TextConstants.OrderInfoModule.TableView.BottomItemCell.paymentMethodTitle.rawValue,
            paymentMethodPrice: orderList.paymentDiscount?.formatPrice() ?? "0 ₽",
            resultTitle: TextConstants.OrderInfoModule.TableView.BottomItemCell.resultTitle.rawValue,
            resultPrice: totalPrice.formatPriceWithoutDegree(),
            nextButtonTitle: TextConstants.OrderInfoModule.TableView.BottomItemCell.nextButtonTitle.rawValue,
            userAgreement: TextConstants.OrderInfoModule.TableView.BottomItemCell.userAgreement
        ))))
    }

    //MARK: - Toggle promoCode function
    func togglePromocode(_ isOn: Bool, _ id: UUID) {
        
        let numberOfPromocodes = orderListFormatted.filter {
            switch $0.type {
            case .promo(let promo):
                return promo.isToggle
            default:
                return false
            }
        }.count
        changeToggle(isOn, id)
        amountPrice(isOn, id)
        
        if numberOfPromocodes >= 2 && isOn {
            errorMessage = "Нельзя применить больше 2х промокодов"
            changeToggle(!isOn, id)
            amountPrice(!isOn, id)
        } else {
            changeToggle(isOn, id)
            amountPrice(isOn, id)
        }
    }

    func changeToggle(_ isOn: Bool,_ id: UUID) {
        for (index, item) in orderListFormatted.enumerated() {
            switch item.type {
            case .promo(var promoCell):
                if promoCell.id == id {
                    promoCell.isToggle = isOn
                    orderListFormatted[index] = OrderInfoTableViewModel(type: .promo(promoCell))
                }
                break
            default:
                break
            }
        }
    }
    
    //MARK: - Price formatter
    func formatPrice(for quantity: Int) -> String {
        let suffix: String
        let lastDigit = quantity % 10
        let lastTwoDigits = quantity % 100
        
        if lastTwoDigits >= 11 && lastTwoDigits <= 14 {
            suffix = "товаров"
        } else {
            switch lastDigit {
            case 1:
                suffix = "товар"
            case 2, 3, 4:
                suffix = "товара"
            default:
                suffix = "товаров"
            }
        }
        
        return "Цена за \(quantity) \(suffix)"
    }
}
