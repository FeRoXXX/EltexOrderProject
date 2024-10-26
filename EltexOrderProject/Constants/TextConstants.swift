//
//  TextConstants.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 19.10.2024.
//

import UIKit

enum TextConstants {
    enum ActivatePromocodeModule {
        enum ActivatePromocodeViewController: String {
            case title = "Применить промокод"
        }
        
        enum ActivatePromocodeView: String {
            case buttonText = "Применить"
        }
        
        enum PromoCodeTextField: String {
            case textFieldTitle = "Введите код"
        }
    }
    
    enum OrderInfoModule {
        enum TableView {
            enum TopItemCell: String {
                case title = "Промокоды"
                case info = "На один товар можно применить только один промокод"
                case buttonTitle = "Применить промокод"
            }
            
            enum HidePromoCodeCell: String {
                case title = "Скрыть промокоды"
            }
            
            enum BottomItemCell: String {
                case discountTitle = "Скидки"
                case promoCodeTitle = "Промокоды"
                case paymentMethodTitle = "Способы оплаты"
                case resultTitle = "Итого"
                case nextButtonTitle = "Оформить заказ"
                static let userAgreement = makeUserAgreement()
                
                private static func makeUserAgreement() -> NSAttributedString{
                    let fullText = "Нажимая кнопку «Оформить заказ»,\nВы соглашаетесь с Условиями оферты"
                    let attributedString = NSMutableAttributedString(string: fullText)

                    let fullRange = NSRange(location: 0, length: fullText.count)
                    attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: fullRange)
                    attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: fullRange)

                    if let offerRange = fullText.range(of: "Условиями оферты") {
                        let nsRange = NSRange(offerRange, in: fullText)
                        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: nsRange)
                        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: nsRange)
                    }
                    
                    return attributedString
                }
            }
        }
        
        enum View: String {
            case popUpText = "Промокод активирован"
        }
    }
}
