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

final class ProductFeedbackViewModel {
    
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
    
    //MARK: - On checkBox tapped
    
    func onCheckBoxTapped() {
        
        for (index, element) in formattedDataList.enumerated() {
            switch element {
            case .sendReviewCell(var data):
                data.checkBox.isActive = !data.checkBox.isActive
                if data.checkBox.isActive {
                    data.checkBox.image = "checkbox.fill"
                    formattedDataList[index] = .sendReviewCell(data)
                    onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                } else {
                    data.checkBox.image = "checkbox"
                    formattedDataList[index] = .sendReviewCell(data)
                    onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                }
            default:
                break
            }
        }
    }
    
    //MARK: - On sendButton tapped
    
    func onSendButtonTapped() {
        
        for (index, element) in formattedDataList.enumerated() {
            switch element {
            case .productStarsCell(let data):
                if data.rating.currentRating == .none {
                    formattedDataList.insert(.starsErrorCell(.init(errorLabel: Constants.StarsErrorCell.title.rawValue)), at: index + 1)
                    onCellInsertAtIndex.value = IndexPath(row: index + 1, section: 0)
                }
            default:
                break
            }
        }
    }
    
    func onAddPhotoEmptyIsTapped() {
        
        for (index, element) in formattedDataList.enumerated() {
            switch element {
            case .addPhotoOrVideoEmptyCell:
                formattedDataList[index] = .addPhotoOrVideoCell(.init(cell: [.init(image: imageArray[0]), .init(image: nil)]))
                onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
            default:
                break
            }
        }
    }
    
    func onAddNewPhotoIsTapped() {
        
        for (index, element) in formattedDataList.enumerated() {
            switch element {
            case .addPhotoOrVideoCell(var data):
                if data.cell.count < 7 {
                    data.cell.insert(.init(image: imageArray[data.cell.count - 1]), at: data.cell.count - 1)
                    formattedDataList[index] = .addPhotoOrVideoCell(data)
                    onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                } else {
                    data.cell.removeLast()
                    data.cell.append(.init(image: imageArray[data.cell.count]))
                    formattedDataList[index] = .addPhotoOrVideoCell(data)
                    onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                }
                return
            default:
                break
            }
        }
    }
    
    func onDeletePhotoIsTapped(at id: UUID) {
        
        for (index, element) in formattedDataList.enumerated() {
            switch element {
            case .addPhotoOrVideoCell(var data):
                for (indexSecond, elementSecond) in data.cell.enumerated() {
                    if elementSecond.id == id {
                        data.cell.remove(at: indexSecond)
                        if data.cell.count == 1 {
                            formattedDataList[index] = .addPhotoOrVideoEmptyCell(.init(title: Constants.AddPhotoOrVideoEmptyCell.title.rawValue, description: Constants.AddPhotoOrVideoEmptyCell.description.rawValue))
                            onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                        } else if data.cell.count == 6 && data.cell.last != .init(image: nil) {
                            data.cell.append(.init(image: nil))
                            formattedDataList[index] = .addPhotoOrVideoCell(data)
                            onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                        } else {
                            formattedDataList[index] = .addPhotoOrVideoCell(data)
                            onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
                        }
                    }
                }
            default:
                break
            }
        }
    }
    
    func onStarsRatingTapped(touch: Double, width: CGFloat) {
        switch DataModel.ProductStarsCell.StarsRatingView.TapLocation.getLocation(touch: touch, firstElementLocation: width) {
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
    
    func createUpdateRatingCells(title: String? = nil, currentRating: DataModel.ProductStarsCell.StarsRatingView.TapLocation) {
        for (index, element) in formattedDataList.enumerated() {
            switch element {
            case .starsErrorCell:
                formattedDataList.remove(at: index)
                onCellDeleteAtIndex.value = IndexPath(row: index, section: 0)
            default:
                break
            }
        }
        
        for (index, element) in formattedDataList.enumerated() {
            switch element {
            case .productStarsCell:
                formattedDataList[index] = .productStarsCell(.init(title: title, rating: .init(currentRating: currentRating)))
                onCellReloadAtIndex.value = IndexPath(row: index, section: 0)
            default:
                break
            }
        }
    }
    
    //MARK: - Text field responder function
    
    func changeFirstResponder(id: UUID) {
        var counterOfCell = 0
        for (index, element) in formattedDataList.enumerated() {
            switch element {
            case .reviewTextCell(let data):
                if id == data.id {
                    counterOfCell += 1
                } else if counterOfCell == 1 {
                    data.isFirstResponder?.value = true
                    formattedDataList[index] = .reviewTextCell(data)
                    counterOfCell += 1
                }
            default:
                break
            }
        }
    }
}

//MARK: - Private extension

private extension ProductFeedbackViewModel {
    
    //MARK: - Load formatted function
    
    func loadAndBuildFormattedData(placeholder: String, numberOfResponder: Int) {
        formattedDataList.append(.reviewTextCell(.init(placeholder: placeholder, isFirstResponder: .init(false))))
    }
    
    //MARK: - Formatted data function

    func formatReceivedDataFirst() {
        formattedDataList.append(.productInfoCell(.init(title: receivedData.title, description: Constants.ProductInfoCell.description.rawValue, imageName: receivedData.imageName)))
        formattedDataList.append(.productStarsCell(.init(title: Constants.ProductStarsCell.title.rawValue, rating: .init(currentRating: .none))))
        formattedDataList.append(.addPhotoOrVideoEmptyCell(.init(title: Constants.AddPhotoOrVideoEmptyCell.title.rawValue, description: Constants.AddPhotoOrVideoEmptyCell.description.rawValue)))
        loadAndBuildFormattedData(placeholder: Constants.ReviewTextCell.placeholderFirst.rawValue, numberOfResponder: 1)
        loadAndBuildFormattedData(placeholder: Constants.ReviewTextCell.placeholderSecond.rawValue, numberOfResponder: 2)
        loadAndBuildFormattedData(placeholder: Constants.ReviewTextCell.placeholderThird.rawValue, numberOfResponder: 3)
        formattedDataList.append(.sendReviewCell(.init(buttonTitle: Constants.SendReviewCell.buttonTitle.rawValue, userAgreement: Constants.SendReviewCell.userAgreement.rawValue, userAgreementHighlighted: Constants.SendReviewCell.userAgreementHighlighted.rawValue, checkBox: .init(title: Constants.SendReviewCell.checkBoxTitle.rawValue, isActive: false, image: Constants.SendReviewCell.checkBoxImage.rawValue))))
        onDataReload.value = true
    }
}
