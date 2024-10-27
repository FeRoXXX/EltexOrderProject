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
    private var alreadyHide: Int = 0
    private var orderListFormatted: [OrderInfoTableViewModel] {
        didSet {
            var indexes: [IndexPath] = []
            let newData = filterForHiddenPromoCode(orderListFormatted)
            let oldData = filterForHiddenPromoCode(oldValue)
            
            for (index, element) in oldValue.enumerated() {
                let newElement = orderListFormatted[index]
                var shouldAppendIndex = false
                
                switch (element.type, newElement.type) {
                case (.topItem(let oldData), .topItem(let data)):
                    shouldAppendIndex = oldData != data
                case (.promo(let oldData), .promo(let data)):
                    shouldAppendIndex = oldData != data
                case (.hidePromo(let oldData), .hidePromo(let data)):
                    shouldAppendIndex = oldData != data
                case (.bottomItem(let oldData), .bottomItem(let data)):
                    shouldAppendIndex = oldData != data
                default:
                    shouldAppendIndex = true
                }
                
                if shouldAppendIndex {
                    var adjustedIndex = 0
                    if oldData.count != newData.count {
                        adjustedIndex =  index - alreadyHide
                    } else {
                        adjustedIndex =  (index < orderListFormatted.count - 2) ? index : index - alreadyHide
                    }
                    indexes.append(.init(row: adjustedIndex, section: 0))
                }
            }
            if indexes.count == oldValue.count - 1 {
                delegate?.cellDidChange(newData)
            } else if newData.count < oldData.count {
                delegate?.deleteRows(at: indexes, data: newData)
            } else if newData.count > oldData.count {
                delegate?.insertRows(at: indexes, data: newData)
            } else if newData.count == oldData.count {
                delegate?.reloadCell(at: indexes, data: newData)
            }
        }
    }
    
    private var errorMessage: String = "" {
        didSet {
            delegate?.showAlert(message: errorMessage)
        }
    }
    
    private var snackBarText: String = "" {
        didSet {
            delegate?.activateSnackBar(snackBarText)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: .init(block: { [weak self] in
                self?.delegate?.deactivateSnackBar()
            }))
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
    
    //MARK: - Set new promocode to viewModel
    func setViewModelData(_ data: Order.Promocode) {
        snackBarText = TextConstants.OrderInfoModule.View.popUpText.rawValue
        var index = 0
        orderList.availableForActive.forEach {
            if $0.title == data.title {
                orderList.availableForActive.remove(at: index)
            }
            index += 1
        }
        
        var cellIsHide: Bool = true
        orderListFormatted.forEach {
            if case let .hidePromo(data) = $0.type {
                cellIsHide = data.isHidden
            }
        }
        
        if cellIsHide {
            changeHideButtonTitle()
            alreadyHide = 0
            addNewPromoCode(with: data)
            changeToggleWhenAddNew()
            changeHideButtonTitle()
        } else {
            alreadyHide = 0
            addNewPromoCode(with: data)
            changeToggleWhenAddNew()
        }
    }
}

//MARK: - Private extension
private extension OrderInfoViewModel {
    
    //MARK: - Add new promocode to List
    func addNewPromoCode(with data: Order.Promocode) {
        for (index, element) in orderListFormatted.enumerated() {
            if case .promo(_) = element.type {
                orderListFormatted.insert(.init(type: .promo(.init(title: data.title, percent: data.percent, date: data.endDate?.formatDate(), additionalInformation: data.info, isToggle: false, toggle: { [weak self] isOn, id in
                    self?.togglePromocode(isOn, id)
                }))), at: index)
                return
            }
        }
    }
    
    //MARK: - Change toggle for new promocode
    func changeToggleWhenAddNew() {
        var togglePromoCodeCount = 0
        var promoCodeFirstID: UUID?
        for element in orderListFormatted {
            if case let .promo(promoCell) = element.type {
                if promoCodeFirstID == nil {
                    promoCodeFirstID = promoCell.id
                }
                if promoCell.isToggle {
                    togglePromoCodeCount += 1
                    if togglePromoCodeCount == 2 {
                        togglePromocode(false, promoCell.id)
                    }
                }
            }
        }
        if let promoCodeFirstID {
            togglePromocode(true, promoCodeFirstID)
        }
    }
    
    //MARK: - Show all promocodes
    func activeAllPromocodes() {
        var index = 0
        orderListFormatted.forEach {
            switch $0.type {
            case .promo(var promoCell):
                promoCell.isHidden = false
                orderListFormatted[index] = .init(type: .promo(promoCell))
                index += 1
                break
            default:
                index += 1
                break
            }
        }
    }
    
    //MARK: - Formatted Top cell function
    func formattedTopCell() {
        orderListFormatted.append(.init(
            type: .topItem(.init(
                title: TextConstants.OrderInfoModule.TableView.TopItemCell.title.rawValue,
                info: TextConstants.OrderInfoModule.TableView.TopItemCell.info.rawValue,
                buttonTitle: TextConstants.OrderInfoModule.TableView.TopItemCell.buttonTitle.rawValue,
                buttonAction: { [weak self] in
                    guard let self else { return }
                    self.delegate?.openActivePromocode(self.orderList.availableForActive)
                })))
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
            title: TextConstants.OrderInfoModule.TableView.HidePromoCodeCell.title.rawValue,
            hidePromoCode: { [weak self] in
                self?.changeHideButtonTitle()
            },
            isHidden: false
        ))))
    }
    
    //MARK: - PromoCode hide function
    func hidePromoCode() {
        var index = 0
        var activePromo = 0
        var countOfPromo = 0
        let activePromoCount = orderListFormatted.filter {
            if case let .promo(data) = $0.type {
                return data.isToggle
            }
            return false
        }.count
        
        alreadyHide = 0
        orderListFormatted.forEach {
            switch $0.type {
            case .promo(var promoCell):
                if promoCell.isToggle {
                    countOfPromo += 1
                } else {
                    if 3 - activePromoCount == activePromo {
                        promoCell.isHidden = !promoCell.isHidden
                        orderListFormatted[index] = .init(type: .promo(promoCell))
                        if promoCell.isHidden {
                            alreadyHide += 1
                        }
                    } else {
                        countOfPromo += 1
                        activePromo += 1
                    }
                }
                index += 1
            default:
                index += 1
                break
            }
        }
    }
    
    //MARK: - Change hide button title
    func changeHideButtonTitle() {
        var index = 0
        orderListFormatted.forEach {
            switch $0.type {
            case .hidePromo(var hidePromoCell):
                hidePromoCell.isHidden = !hidePromoCell.isHidden
                switch hidePromoCell.isHidden {
                case true:
                    hidePromoCell.title = "Показать промокоды"
                    hidePromoCode()
                case false:
                    hidePromoCell.title = "Скрыть промокоды"
                    alreadyHide = 0
                    activeAllPromocodes()
                }
                orderListFormatted[index] = .init(type: .hidePromo(hidePromoCell))
                index += 1
            default:
                index += 1
                break
            }
        }
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
                    if case let .promo(promoCell) = $0.type {
                        let discountAmount = totalPriceOutput * (Double(promoCell.percent) / 100)
                        totalPrice -= discountAmount
                        promoCodePrice += discountAmount
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
        
        if numberOfPromocodes >= 2 && isOn {
            errorMessage = "Нельзя применить больше 2х промокодов"
            changeToggle(!isOn, id)
        } else {
            changeToggle(isOn, id)
            amountPrice(isOn, id)
        }
    }

    func changeToggle(_ isOn: Bool,_ id: UUID) {
        var hideIndex = 0
        for (index, item) in orderListFormatted.enumerated() {
            if case var .promo(promoCell) = item.type {
                if promoCell.id == id {
                    if promoCell.isToggle != isOn {
                        promoCell.isToggle = isOn
                        orderListFormatted[index] = OrderInfoTableViewModel(type: .promo(promoCell))
                    } else {
                        delegate?.reloadCell(at: [.init(row: index - hideIndex, section: 0)], data: filterForHiddenPromoCode(orderListFormatted))
                    }
                }
                if promoCell.isHidden {
                    hideIndex += 1
                }
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
    
    //MARK: - filter hidden promoCode
    func filterForHiddenPromoCode(_ array: [OrderInfoTableViewModel]) -> [OrderInfoTableViewModel]{
        array.filter {
            switch $0.type {
            case .promo(let data):
                if data.isHidden {
                    return false
                }
                return true
            default:
                return true
            }
        }
    }
}
