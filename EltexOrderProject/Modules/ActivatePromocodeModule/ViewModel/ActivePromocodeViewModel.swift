//
//  ActivePromocodeViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 25.10.2024.
//

import Foundation

final class ActivePromocodeViewModel {
    
    //MARK: - Properties
    weak var delegate: ActivePromocodeViewModelDelegate? {
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
    
    //MARK: - Initialization
    init(promoCodesList: [Order.Promocode], previousViewModel: OrderInfoViewModel) {
        self.promoCodesList = promoCodesList
        self.previousViewModel = previousViewModel
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
        
        for element in promoCodesList {
            if element.title == promoCode {
                previousViewModel?.setViewModelData(element)
                delegate?.closeWindow()
                return
            }
        }
        errorMessage = "Такого промокода не существует"
    }
}
