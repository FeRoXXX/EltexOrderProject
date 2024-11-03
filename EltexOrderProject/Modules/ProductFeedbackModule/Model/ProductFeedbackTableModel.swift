//
//  ProductFeedbackTableModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import Foundation

struct ProductFeedbackTableModel {
    
    let type: DataModel
    let id: UUID
    
    init(type: DataModel, id: UUID? = nil) {
        self.type = type
        self.id = id ?? UUID()
    }
    
    enum DataModel: Equatable {
        
        case productInfoCell(ProductInfoCell)
        case productStarsCell(ProductStarsCell)
        case addPhotoOrVideoEmptyCell(AddPhotoOrVideoEmptyCell)
        case reviewTextCell(ReviewTextCell)
        case sendReviewCell(SendReviewCell)
        case starsErrorCell(StarsErrorCell)
        case addPhotoOrVideoCell(AddPhotoOrVideoCell)
        
        struct ProductInfoCell: Equatable {
            let title: String
            let description: String
            let imageName: String
        }
        
        struct ProductStarsCell: Equatable {
            static func == (lhs: ProductFeedbackTableModel.DataModel.ProductStarsCell, rhs: ProductFeedbackTableModel.DataModel.ProductStarsCell) -> Bool {
                return lhs.title == rhs.title && lhs.rating == rhs.rating
            }
            
            let title: String?
            let rating: StarsRatingView
            
            struct StarsRatingView: Equatable {
                static func == (lhs: ProductFeedbackTableModel.DataModel.ProductStarsCell.StarsRatingView, rhs: ProductFeedbackTableModel.DataModel.ProductStarsCell.StarsRatingView) -> Bool {
                    return lhs.currentRating == rhs.currentRating
                }
                
                let currentRating: TapLocation
                let touchLocation: ((Double, CGFloat) -> Void)?
                
                enum TapLocation {
                    case first
                    case second
                    case third
                    case fourth
                    case fifth
                    case none
                    
                    static func getLocation(touch: Double, firstElementLocation: CGFloat) -> Self {
                        
                        switch touch {
                        case 0..<firstElementLocation + 8:
                            return .first
                        case firstElementLocation..<(firstElementLocation + 8)*2:
                            return .second
                        case firstElementLocation*2..<(firstElementLocation + 8)*3:
                            return .third
                        case firstElementLocation*3..<(firstElementLocation + 8)*4:
                            return .fourth
                        default:
                            return .fifth
                        }
                    }
                }
            }
        }
        
        struct AddPhotoOrVideoEmptyCell: Equatable {
            let title: String
            let description: String
            let cellIsTapped: (() -> Void)?
            
            static func == (lhs: ProductFeedbackTableModel.DataModel.AddPhotoOrVideoEmptyCell, rhs: ProductFeedbackTableModel.DataModel.AddPhotoOrVideoEmptyCell) -> Bool {
                lhs.description == rhs.description && lhs.title == rhs.title
            }
        }
        
        struct ReviewTextCell: Equatable {
            
            let placeholder: String
            weak var isFirstResponder: Observable<Bool>?
            let id: UUID = UUID()
            var changeFirstResponder: ((UUID)->Void)?
            
            static func == (lhs: ProductFeedbackTableModel.DataModel.ReviewTextCell, rhs: ProductFeedbackTableModel.DataModel.ReviewTextCell) -> Bool {
                return lhs.placeholder == rhs.placeholder && lhs.id == rhs.id
            }
        }
        
        struct SendReviewCell: Equatable {
            let buttonTitle: String
            let userAgreement: String
            var checkBox: CheckBoxView
            
            struct CheckBoxView: Equatable {
                let title: String
                var isActive: Bool
                var image: String
                var checkBoxTapped: ((Bool)->Void)?
                
                static func == (lhs: ProductFeedbackTableModel.DataModel.SendReviewCell.CheckBoxView, rhs: ProductFeedbackTableModel.DataModel.SendReviewCell.CheckBoxView) -> Bool {
                    return lhs.title == rhs.title && lhs.image == rhs.image && lhs.isActive == rhs.isActive
                }
            }
        }
        
        struct StarsErrorCell: Equatable {
            let errorLabel: String
        }
        
        struct AddPhotoOrVideoCell: Equatable {
            var cell: [PhotoCell]
            
            struct PhotoCell: Equatable {
                let image: String?
                let id: UUID = UUID()
                let cellIsTapped: (() -> Void)?
                let deleteButtonTapped: ((UUID) -> Void)?
                
                static func == (lhs: ProductFeedbackTableModel.DataModel.AddPhotoOrVideoCell.PhotoCell, rhs: ProductFeedbackTableModel.DataModel.AddPhotoOrVideoCell.PhotoCell) -> Bool {
                    return lhs.image == rhs.image
                }
            }
        }
        
        static func == (lhs: DataModel, rhs: DataModel) -> Bool {
            switch (lhs, rhs) {
            case (.addPhotoOrVideoCell, .addPhotoOrVideoCell),
                (.addPhotoOrVideoEmptyCell, .addPhotoOrVideoEmptyCell),
                (.productInfoCell, .productInfoCell),
                (.productStarsCell, .productStarsCell),
                (.reviewTextCell,.reviewTextCell),
                (.sendReviewCell, .sendReviewCell),
                (.starsErrorCell, .starsErrorCell):
                return true
            default:
                return false
            }
        }
    }
}
