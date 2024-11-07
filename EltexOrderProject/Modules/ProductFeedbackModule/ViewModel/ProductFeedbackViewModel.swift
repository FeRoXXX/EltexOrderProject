//
//  ProductFeedbackViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import Foundation

fileprivate enum Constants {
    
    enum ProductInfoCell: String {
        case description = "Размер: 17"
    }
    
    enum ProductStarsCell: String {
        case title = "Ваша оценка"
    }
    
    enum AddPhotoOrVideoEmptyCell: String {
        case title = "Добавьте фото или видео"
        case description = "Нажмите, чтобы добавить файл"
    }
    
    enum ReviewTextCell: String {
        case placeholderFirst = "Достоинства"
        case placeholderSecond = "Недостатки"
        case placeholderThird = "Комментарий"
    }
    
    enum SendReviewCell: String {
        case buttonTitle = "Отправить"
        case checkBoxTitle = "Оставить отзыв анонимно"
        case checkBoxImage = "checkbox"
        case userAgreement = "Перед отправкой отзыва, пожалуйста,\n ознакомьтесь с правилами публикации"
        case userAgreementHighlighted = "правилами публикации"
    }
    
    enum StarsErrorCell: String {
        case title = "Для продолжения поставьте оценку товару"
    }
}

final class ProductFeedbackViewModel: ProductFeedbackViewModelOutput {
    
    //MARK: - Private properties
    
    private var receivedData: ProductTableModel
    private var imageArray: [String] = ["firstHand", "secondHand", "thirdHand", "fourthHand", "fifthHand", "sixthHand", "seventhHand"]
    
    //MARK: - Public properties
    
    var onDataReload: Observable<Bool> = Observable(nil)
    var onCellReloadAtIndex: Observable<IndexPath> = Observable(nil)
    var onCellInsertAtIndex: Observable<IndexPath> = Observable(nil)
    var onCellDeleteAtIndex: Observable<IndexPath> = Observable(nil)
    var formattedDataList: [DataModel] = []
    
    //MARK: - Initialization
    
    init(receivedData: ProductTableModel) {
        self.receivedData = receivedData
        formatReceivedDataFirst()
    }
    
    //MARK: - Deinit
    
    deinit {
        formattedDataList.removeAll()
    }
}

//MARK: - ProductFeedbackViewModelInput

extension ProductFeedbackViewModel: ProductFeedbackViewModelInput {
    //MARK: - On checkBox tapped
    
    func onCheckBoxTapped() {
        
        for (index, element) in formattedDataList.enumerated() {
            if case let .sendReviewCell(data) = element {
                guard let value = data.checkBox.isActive.value else { return }
                data.checkBox.isActive.value = !value
                if data.checkBox.isActive.value ?? false {
                    formattedDataList[index] = .sendReviewCell(data)
                } else {
                    formattedDataList[index] = .sendReviewCell(data)
                }
            }
        }
    }
    
    //MARK: - On sendButton tapped
    
    func onSendButtonTapped() {
        if formattedDataList.contains(where: { data in
            if case .starsErrorCell = data {
                return true
            }
            return false
        }) { return }
        for (index, element) in formattedDataList.enumerated() {
            if case let .productStarsCell(data) = element {
                if data.rating.currentRating == .none {
                    formattedDataList.insert(.starsErrorCell(.init(errorLabel: Constants.StarsErrorCell.title.rawValue)), at: index + 1)
                    onCellInsertAtIndex.value = IndexPath(row: index + 1, section: 0)
                }
            }
        }
    }
    
    //MARK: - Add photo tapped
    
    func onAddPhotoEmptyIsTapped() {
        
        for (index, element) in formattedDataList.enumerated() {
            if case .addPhotoOrVideoEmptyCell = element {
                formattedDataList[index] = .addPhotoOrVideoCell(AddPhotoOrVideoCellModel(cell: [.init(image: imageArray[0]), .init(image: nil)]))
                onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
            }
        }
    }
    
    func onAddNewPhotoIsTapped() {
        
        for (index, element) in formattedDataList.enumerated() {
            if case var .addPhotoOrVideoCell(data) = element {
                if data.cell.count < 7 {
                    data.cell.insert(.init(image: findImage(data.cell)), at: data.cell.count - 1)
                    formattedDataList[index] = .addPhotoOrVideoCell(data)
                    onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                } else {
                    data.cell.removeLast()
                    data.cell.append(.init(image: findImage(data.cell)))
                    formattedDataList[index] = .addPhotoOrVideoCell(data)
                    onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                }
            }
        }
    }
    
    //MARK: - Delete photo tapped
    
    func onDeletePhotoIsTapped(at id: UUID) {
        
        for (index, element) in formattedDataList.enumerated() {
            if case var .addPhotoOrVideoCell(data) = element {
                for (indexSecond, item) in data.cell.enumerated() {
                    guard item.id == id else { continue }
                    data.cell.remove(at: indexSecond)
                    if data.cell.count == 1 {
                        formattedDataList[index] = .addPhotoOrVideoEmptyCell(.init(title: Constants.AddPhotoOrVideoEmptyCell.title.rawValue, description: Constants.AddPhotoOrVideoEmptyCell.description.rawValue))
                        onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                    } else if data.cell.count == 6 && data.cell.last?.image != nil {
                        data.cell.append(.init(image: nil))
                        formattedDataList[index] = .addPhotoOrVideoCell(data)
                        onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                    } else {
                        formattedDataList[index] = .addPhotoOrVideoCell(data)
                        onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                    }
                }
            }
        }
    }
    
    //MARK: - Stars rating tapped
    
    func onStarsRatingTapped(touch: Double, width: CGFloat) {
        switch ProductStarsCellModel.StarsRatingViewModel.TapLocation.getLocation(touch: touch, firstElementLocation: width) {
        case .first:
            createUpdateRatingCells(title: "Ужасно", currentRating: .first)
        case .second:
            createUpdateRatingCells(title: "Плохо", currentRating: .second)
        case .third:
            createUpdateRatingCells(title: "Нормально", currentRating: .third)
        case .fourth:
            createUpdateRatingCells(title: "Хорошо", currentRating: .fourth)
        case .fifth:
            createUpdateRatingCells(title: "Отлично", currentRating: .fifth)
        case .none:
            createUpdateRatingCells(currentRating: .none)
        }
    }
    
    //MARK: - Text field responder function
    
    func changeFirstResponder(id: UUID) {
        var counterOfCell = 0
        for (index, element) in formattedDataList.enumerated() {
            if case let .reviewTextCell(data) = element {
                if id == data.id {
                    counterOfCell += 1
                } else if counterOfCell == 1 {
                    data.isFirstResponder?.value = true
                    formattedDataList[index] = .reviewTextCell(data)
                    counterOfCell += 1
                }
            }
        }
    }
}

//MARK: - Private extension

private extension ProductFeedbackViewModel {
    
    //MARK: - Formatted data function

    func formatReceivedDataFirst() {
        formattedDataList = [
            .productInfoCell(ProductInfoCellModel(title: receivedData.title,
                                                  description: Constants.ProductInfoCell.description.rawValue,
                                                  imageName: receivedData.imageName)),
            .productStarsCell(ProductStarsCellModel(title: Constants.ProductStarsCell.title.rawValue,
                                                    rating: ProductStarsCellModel.StarsRatingViewModel(currentRating: .none))),
            .addPhotoOrVideoEmptyCell(AddPhotoOrVideoEmptyCellModel(title: Constants.AddPhotoOrVideoEmptyCell.title.rawValue,
                                                                    description: Constants.AddPhotoOrVideoEmptyCell.description.rawValue)),
            .reviewTextCell(ReviewTextCellModel(placeholder: Constants.ReviewTextCell.placeholderFirst.rawValue, isFirstResponder: Observable(nil))),
            .reviewTextCell(ReviewTextCellModel(placeholder: Constants.ReviewTextCell.placeholderSecond.rawValue, isFirstResponder: Observable(nil))),
            .reviewTextCell(ReviewTextCellModel(placeholder: Constants.ReviewTextCell.placeholderThird.rawValue, isFirstResponder: Observable(nil))),
            .sendReviewCell(SendReviewCellModel(buttonTitle: Constants.SendReviewCell.buttonTitle.rawValue,
                                                userAgreement: Constants.SendReviewCell.userAgreement.rawValue,
                                                userAgreementHighlighted: Constants.SendReviewCell.userAgreementHighlighted.rawValue,
                                                checkBox: SendReviewCellModel.CheckBoxViewModel(title: Constants.SendReviewCell.checkBoxTitle.rawValue,
                                                                                                isActive: Observable(false))))
        ]
        onDataReload.value = true
    }
    
    //MARK: - Create rating cells
    
    func createUpdateRatingCells(title: String? = nil, currentRating: ProductStarsCellModel.StarsRatingViewModel.TapLocation) {
        for (index, element) in formattedDataList.enumerated() {
            if case .starsErrorCell = element {
                formattedDataList.remove(at: index)
                onCellDeleteAtIndex.value = IndexPath(row: index, section: 0)
            }
        }
        
        for (index, element) in formattedDataList.enumerated() {
            if case .productStarsCell = element {
                formattedDataList[index] = .productStarsCell(.init(title: title, rating: .init(currentRating: currentRating)))
                onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
            }
        }
    }
    
    //MARK: - Find nonrepeating image
    
    func findImage(_ currentImageList: [AddPhotoOrVideoCellModel.PhotoCellModel]) -> String {
        
        for element in imageArray {
            var isContains = false
            for elementSecond in currentImageList {
                if elementSecond.image == element {
                    isContains = true
                }
            }
            if !isContains {
                return element
            }
        }
        return ""
    }
}
