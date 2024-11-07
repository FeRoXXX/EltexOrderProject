//
//  SendReviewCellModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.11.2024.
//

import Foundation

struct SendReviewCellModel: Equatable {
    let buttonTitle: String
    let userAgreement: String
    let userAgreementHighlighted: String
    var checkBox: CheckBoxViewModel
    
    struct CheckBoxViewModel: Equatable {
        let title: String
        var isActive: Observable<Bool>
        
        static func == (lhs: CheckBoxViewModel, rhs: CheckBoxViewModel) -> Bool {
            return lhs.title == rhs.title && lhs.isActive.value == rhs.isActive.value
        }
    }
}
