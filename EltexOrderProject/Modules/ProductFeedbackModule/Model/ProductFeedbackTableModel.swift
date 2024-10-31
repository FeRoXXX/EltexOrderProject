//
//  ProductFeedbackTableModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import Foundation

struct ProductFeedbackTableModel {
    
    var type: DataModel
    
    enum DataModel {
        
        case productInfoCell(ProductInfoCell)
        case productStarsCell(ProductStarsCell)
        case addPhotoOrVideoEmptyCell(AddPhotoOrVideoEmptyCell)
        case reviewTextCell(ReviewTextCell)
        case sendReviewCell(SendReviewCell)
        
        struct ProductInfoCell {
            let title: String
            let description: String
            let imageName: String
        }
        
        struct ProductStarsCell {
            let title: String
        }
        
        struct AddPhotoOrVideoEmptyCell {
            let title: String
            let description: String
        }
        
        struct ReviewTextCell {
            let placeholder: String
        }
        
        struct SendReviewCell {
            let buttonTitle: String
            let userAgreement: String
            let checkBox: CheckBoxView
            
            struct CheckBoxView {
                let title: String
            }
        }
    }
}
