//
//  ActivePromocodeViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 25.10.2024.
//

import Foundation

final class ActivePromocodeViewModel {
    
    //MARK: - Properties
    weak var delegate: ActivePromocodeViewModelDelegate?{
        didSet {
            delegate?.setupTitle(title)
            activePromocodeData.forEach {
                delegate?.setData($0)
            }
        }
    }
    
    private var activePromocodeData: [ActivePromocodeModel] {
        didSet {
            activePromocodeData.forEach {
                delegate?.setData($0)
            }
        }
    }
    
    private var errorMessage: String = "" {
        didSet {
            delegate?.makeAlert(errorMessage)
        }
    }
    
    private var title: String {
        didSet {
            delegate?.setupTitle(title)
        }
    }
    
    private weak var previousViewModel: OrderInfoViewModel?
    private var promoCodesList: [Order.Promocode]
    private var viewModel: OrderMakingViewModel?
    
    //MARK: - Initialization
    init(promoCodesList: [Order.Promocode] = [], previousViewModel: OrderInfoViewModel? = nil, viewModel: OrderMakingViewModel? = nil) {
        self.promoCodesList = promoCodesList
        self.previousViewModel = previousViewModel
        self.viewModel = viewModel
        self.title = TextConstants.ActivatePromocodeModule.ActivatePromocodeViewController.title.rawValue
        activePromocodeData = []
        activePromocodeData.append(
            .init(type: .view(.init(buttonText: TextConstants.ActivatePromocodeModule.ActivatePromocodeView.buttonText.rawValue, textFieldShouldBeginEditing: { [weak self] in
            self?.delegate?.hideAlert()
        },
                                    activeButtonClicked: { [weak self] promoCode in
            self?.checkPromoCode(promoCode)
        }))))
        activePromocodeData.append(.init(type: .textField(.init(textFieldTitle: TextConstants.ActivatePromocodeModule.PromoCodeTextField.textFieldTitle.rawValue, clearButtonClicked: { [weak self] in
            self?.delegate?.clearTextField()
        }))))
    }
}

//MARK: - Private extension
private extension ActivePromocodeViewModel {
    
    func checkPromoCode(_ promoCode: String?) {
        
        if previousViewModel != nil {
            
            for element in promoCodesList {
                if element.title == promoCode {
                    previousViewModel?.setViewModelData(element)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: .init(block: { [weak self] in
                        self?.delegate?.closeWindow()
                    }))
                    return
                }
            }
            errorMessage = "Такого промокода не существует"
        } else {
            guard let viewModel else { return }
            for element in promoCodesList {
                if element.title == promoCode {
                    let promocode = PromoCode(title: element.title, date: "По 15 декабря", description: element.info, percent: element.percent, isActive: element.active)
                    viewModel.addNewPromocode(promocode: promocode)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: .init(block: { [weak self] in
                        self?.delegate?.closeWindow()
                    }))
                    return
                }
            }
            errorMessage = "Такого промокода не существует"
        }
    }
}
