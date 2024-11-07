//
//  ProductFeedbackTableModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import Foundation
    
enum DataModel: Equatable {
    
    //MARK: - Product image and description
    case productInfoCell(ProductInfoCellModel)
    
    //MARK: - Product rating and estimation
    case productStarsCell(ProductStarsCellModel)
    
    //MARK: - Add media button
    case addPhotoOrVideoEmptyCell(AddPhotoOrVideoEmptyCellModel)
    
    //MARK: - Product user review
    case reviewTextCell(ReviewTextCellModel)
    
    //MARK: - Product send review button and checkbox
    case sendReviewCell(SendReviewCellModel)
    
    //MARK: - Error
    case starsErrorCell(StarsErrorCellModel)
    
    //MARK: - Collection of media elements
    case addPhotoOrVideoCell(AddPhotoOrVideoCellModel)
}
