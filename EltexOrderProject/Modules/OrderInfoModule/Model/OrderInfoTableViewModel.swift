//
//  OrderInfoTableViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 17.10.2024.
//

import Foundation

struct OrderInfoTableViewModel: Equatable {
    
    //MARK: - Properties
    var type: ViewModelType
    
    //MARK: - Enum
    enum ViewModelType: Equatable {
        
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
            var isToggle: Bool
            let toggle: ((Bool, UUID) -> Void)?
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
            var promoCodePrice: String
            let paymentMethodTitle: String
            let paymentMethodPrice: String
            let resultTitle: String
            var resultPrice: String
            let nextButtonTitle: String
            let userAgreement: NSAttributedString
        }
        
        case topItem(TopItemCell)
        case promo(PromoCell)
        case hidePromo(HidePromoCell)
        case bottomItem(BottomItemCell)
        
        static func== (lhs: ViewModelType, rhs: ViewModelType) -> Bool {
            switch (lhs, rhs) {
            case (.topItem, .topItem),
                (.promo, .promo),
                (.hidePromo, .hidePromo),
                (.bottomItem, .bottomItem):
                return true
            default:
                return false
            }
        }
    }
}
