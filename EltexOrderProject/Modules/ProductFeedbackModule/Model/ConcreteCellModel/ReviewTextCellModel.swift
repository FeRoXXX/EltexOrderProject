//
//  ReviewTextCellModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.11.2024.
//

import Foundation

struct ReviewTextCellModel: Equatable {
    
    let placeholder: String
    var isFirstResponder: Observable<Bool>?
    let id: UUID = UUID()
    var changeFirstResponder: ((UUID)->Void)?
    
    static func == (lhs: ReviewTextCellModel, rhs: ReviewTextCellModel) -> Bool {
        return lhs.placeholder == rhs.placeholder && lhs.id == rhs.id
    }
}
