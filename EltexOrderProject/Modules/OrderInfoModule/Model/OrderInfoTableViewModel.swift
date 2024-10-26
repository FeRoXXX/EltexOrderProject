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
        
        struct TopItemCell: Equatable {
            //MARK: - Properties
            let title: String
            let info: String
            let buttonTitle: String
            let buttonAction: (() -> Void)?
            
            static func == (lhs: TopItemCell, rhs: TopItemCell) -> Bool {
                return lhs.title == rhs.title &&
                lhs.info == rhs.info &&
                lhs.buttonTitle == rhs.buttonTitle
            }
        }
        
        struct PromoCell: Equatable {
            //MARK: - Properties
            let id: UUID = UUID()
            let title: String
            let percent: Int
            let date: String?
            let additionalInformation: String?
            var isHidden: Bool = false
            var isToggle: Bool
            let toggle: ((Bool, UUID) -> Void)?
            
            static func == (lhs: PromoCell, rhs: PromoCell) -> Bool {
                return lhs.id == rhs.id &&
                lhs.title == rhs.title &&
                lhs.percent == rhs.percent &&
                lhs.date == rhs.date &&
                lhs.additionalInformation == rhs.additionalInformation &&
                lhs.isToggle == rhs.isToggle &&
                lhs.isHidden == rhs.isHidden
            }
        }
        
        struct HidePromoCell: Equatable {
            //MARK: - Properties
            var title: String
            let hidePromoCode: (() -> Void)?
            var isHidden: Bool
            
            static func== (lhs: HidePromoCell, rhs: HidePromoCell) -> Bool {
                return lhs.title == rhs.title && lhs.isHidden == rhs.isHidden
            }
        }
        
        struct BottomItemCell: Equatable {
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
            
            static func == (lhs: BottomItemCell, rhs: BottomItemCell) -> Bool {
                return lhs.generalTitle == rhs.generalTitle &&
                       lhs.generalPrice == rhs.generalPrice &&
                       lhs.discountTitle == rhs.discountTitle &&
                       lhs.discountPrice == rhs.discountPrice &&
                       lhs.promoCodeTitle == rhs.promoCodeTitle &&
                       lhs.promoCodePrice == rhs.promoCodePrice &&
                       lhs.paymentMethodTitle == rhs.paymentMethodTitle &&
                       lhs.paymentMethodPrice == rhs.paymentMethodPrice &&
                       lhs.resultTitle == rhs.resultTitle &&
                       lhs.resultPrice == rhs.resultPrice &&
                       lhs.nextButtonTitle == rhs.nextButtonTitle &&
                       lhs.userAgreement.string == rhs.userAgreement.string
            }
        }
        
        case topItem(TopItemCell)
        case promo(PromoCell)
        case hidePromo(HidePromoCell)
        case bottomItem(BottomItemCell)
        
        static func == (lhs: ViewModelType, rhs: ViewModelType) -> Bool {
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
