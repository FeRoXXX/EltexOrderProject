//
//  OrderInfoTableViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 17.10.2024.
//

import Foundation

struct OrderInfoTableViewModel {
    
    //MARK: - Properties
    var type: ViewModelType
    
    //MARK: - Enum
    enum ViewModelType {
        
        struct TopItemCell {
            //MARK: - Properties
            let title: String
            let info: String
            let buttonTitle: String
        }

        struct PromoCell {
            //MARK: - Properties
            let id: UUID = UUID()
            let title: String
            let percent: Int
            let date: String?
            let additionalInformation: String?
            let isToggle: Bool
        }

        struct HidePromoCell {
            //MARK: - Properties
            let title: String
        }

        struct BottomItemCell {
            //MARK: - Properties
            let generalTitle: String
            let generalPrice: String
            let discountTitle: String
            let discountPrice: String
            let promoCodeTitle: String
            let promoCodePrice: String
            let paymentMethodTitle: String
            let paymentMethodPrice: String
            let resultTitle: String
            let resultPrice: String
            let nextButtonTitle: String
            let userAgreement: String
        }
        
        case topItem(TopItemCell)
        case promo(PromoCell)
        case hidePromo(HidePromoCell)
        case bottomItem(BottomItemCell)
    }
}
