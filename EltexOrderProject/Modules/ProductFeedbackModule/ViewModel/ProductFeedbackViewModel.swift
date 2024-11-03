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
    
    private var formattedDataList: [ProductFeedbackTableModel] = [] {
        didSet {
            delegate?.updateData(formattedDataList)
        }
    }
    
    private var indexPath: [IndexPath]? = [] {
        didSet {
            delegate?.updateIndexPath(indexPath)
        }
    }
    
    private var receivedData: ProductTableModel
    private var imageArray: [String] = ["firstHand", "secondHand", "thirdHand", "fourthHand", "fifthHand", "sixthHand", "seventhHand"]
    
    //MARK: - Public properties
    
    weak var delegate: ProductFeedbackViewModelDelegate? {
        didSet {
            delegate?.updateData(formattedDataList)
        }
    }
    
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

//MARK: - Private extension

private extension ProductFeedbackViewModel {
    
    //MARK: - Load formatted function
    
    func loadAndBuildFormattedData(placeholder: String, numberOfResponder: Int) {
        formattedDataList.append(.init(type: .reviewTextCell(.init(placeholder: placeholder, isFirstResponder: .init(false), changeFirstResponder: { [weak self] id in
            self?.changeFirstResponder(id: id)
        }))))
    }
    
    //MARK: - Text field responder function
    
    func changeFirstResponder(id: UUID) {
        var counterOfCell = 0
        for (index, element) in formattedDataList.enumerated() {
            switch element.type {
            case .reviewTextCell(let data):
                if id == data.id {
                    counterOfCell += 1
                } else if counterOfCell == 1 {
                    data.isFirstResponder?.value = true
                    formattedDataList[index] = .init(type: .reviewTextCell(data), id: element.id)
                    indexPath = nil
                    counterOfCell += 1
                }
            default:
                break
            }
        }
    }
    
    //MARK: - Formatted data function
    
    func formatReceivedDataFirst() {
        formattedDataList.append(.init(type: .productInfoCell(.init(title: receivedData.title, description: Constants.ProductInfoCell.description.rawValue, imageName: receivedData.imageName))))
        formattedDataList.append(.init(type: .productStarsCell(.init(title: Constants.ProductStarsCell.title.rawValue, rating: .init(currentRating: .none, touchLocation: { [weak self] touch, value in
            self?.updateStarsRating(touch: touch, value: value)
        })))))
        formattedDataList.append(.init(type: .addPhotoOrVideoEmptyCell(.init(title: Constants.AddPhotoOrVideoEmptyCell.title.rawValue, description: Constants.AddPhotoOrVideoEmptyCell.description.rawValue, cellIsTapped: { [weak self] in
            self?.addPhoto()
        }))))
        loadAndBuildFormattedData(placeholder: Constants.ReviewTextCell.placeholderFirst.rawValue, numberOfResponder: 1)
        loadAndBuildFormattedData(placeholder: Constants.ReviewTextCell.placeholderSecond.rawValue, numberOfResponder: 2)
        loadAndBuildFormattedData(placeholder: Constants.ReviewTextCell.placeholderThird.rawValue, numberOfResponder: 3)
        formattedDataList.append(.init(type: .sendReviewCell(.init(buttonTitle: Constants.SendReviewCell.buttonTitle.rawValue, userAgreement: Constants.SendReviewCell.userAgreement.rawValue, userAgreementHighlighted: Constants.SendReviewCell.userAgreementHighlighted.rawValue, checkBox: .init(title: Constants.SendReviewCell.checkBoxTitle.rawValue, isActive: false, image: Constants.SendReviewCell.checkBoxImage.rawValue, checkBoxTapped: { [weak self] value in
            self?.checkBoxTapped(value: value)
        }), sendButtonIsTapped: { [weak self] in
            self?.sendButtonTapped()
        }))))
    }

    //MARK: - Update stars rating function
    
    func updateStarsRating(touch: Double, value: CGFloat) {
        switch ProductFeedbackTableModel.DataModel.ProductStarsCell.StarsRatingView.TapLocation.getLocation(touch: touch, firstElementLocation: value) {
        case .first:
            createUpdateRatingCell(title: "Ужасно", currentRating: .first)
        case .second:
            createUpdateRatingCell(title: "Плохо", currentRating: .second)
        case .third:
            createUpdateRatingCell(title: "Нормально", currentRating: .third)
        case .fourth:
            createUpdateRatingCell(title: "Хорошо", currentRating: .fourth)
        case .fifth:
            createUpdateRatingCell(title: "Отлично", currentRating: .fifth)
        case .none:
            createUpdateRatingCell(currentRating: .none)
        }
    }
 
    //MARK: - Find and replace cell function
    
    func findAndReplaceCell(typeData: ProductFeedbackTableModel) {
        for (index, element) in formattedDataList.enumerated() {
            switch element.type {
            case typeData.type:
                formattedDataList[index] = typeData
                indexPath = [.init(row: index, section: 0)]
                return
            default:
                break
            }
        }
    }

    //MARK: - Create rating cell function
    
    func createUpdateRatingCell(title: String? = nil, currentRating: ProductFeedbackTableModel.DataModel.ProductStarsCell.StarsRatingView.TapLocation) {
        findAndReplaceCell(typeData: .init(type: .productStarsCell(.init(title: title, rating: .init(currentRating: currentRating, touchLocation: { [weak self] touch, value in
            self?.updateStarsRating(touch: touch, value: value)
        })))))
        for (index, element) in formattedDataList.enumerated() {
            switch element.type {
            case .starsErrorCell:
                formattedDataList.remove(at: index)
                indexPath = []
            default:
                break
            }
        }
    }
    
    //MARK: - Add photo function
    
    func addPhoto() {
        for (index, element) in formattedDataList.enumerated() {
            switch element.type {
            case .addPhotoOrVideoEmptyCell(let data):
                formattedDataList[index] = .init(type: .addPhotoOrVideoCell(.init(cell: [.init(image: imageArray[0], cellIsTapped: data.cellIsTapped, deleteButtonTapped: { [weak self] id in
                    self?.deletePhoto(id: id)
                }), .init(image: nil, cellIsTapped: addPhoto, deleteButtonTapped: { [weak self] id in
                    self?.deletePhoto(id: id)
                })])),id: element.id)
                indexPath = [.init(row: index, section: 0)]
            case .addPhotoOrVideoCell(var data):
                if data.cell.count != 7 {
                    data.cell.insert(.init(image: imageArray[data.cell.count - 1], cellIsTapped: { [weak self] in
                        self?.addPhoto()
                    }, deleteButtonTapped: { [weak self] id in
                        self?.deletePhoto(id: id)
                    }), at: data.cell.count - 1)
                    formattedDataList[index] = .init(type: .addPhotoOrVideoCell(data),id: element.id)
                    indexPath = [.init(row: index, section: 0)]
                } else {
                    data.cell.removeLast()
                    data.cell.append(.init(image: imageArray[imageArray.count - 1], cellIsTapped: { [weak self] in
                        self?.addPhoto()
                    }, deleteButtonTapped: { [weak self] id in
                        self?.deletePhoto(id: id)
                    }))
                    formattedDataList[index] = .init(type: .addPhotoOrVideoCell(data),id: element.id)
                    indexPath = [.init(row: index, section: 0)]
                }
            default:
                break
            }
        }
    }
    
    //MARK: - Delete photo function
    
    func deletePhoto(id: UUID) {
        for (indexFirst, element) in formattedDataList.enumerated() {
            switch element.type {
            case .addPhotoOrVideoCell(var data):
                for (index, element) in data.cell.enumerated() {
                    if element.id == id {
                        data.cell.remove(at: index)
                        if data.cell.count == 1 {
                            formattedDataList[indexFirst] = .init(type: .addPhotoOrVideoEmptyCell(.init(title: Constants.AddPhotoOrVideoEmptyCell.title.rawValue, description: Constants.AddPhotoOrVideoEmptyCell.description.rawValue, cellIsTapped: { [weak self] in
                                self?.addPhoto()
                            })))
                            indexPath = [.init(row: indexFirst, section: 0)]
                        } else if data.cell.count == 6 && data.cell.last != .init(image: nil, cellIsTapped: nil, deleteButtonTapped: nil) {
                            data.cell.append(.init(image: nil, cellIsTapped: { [weak self] in
                                self?.addPhoto()
                            }, deleteButtonTapped: { [weak self] id in
                                self?.deletePhoto(id: id)
                            }))
                            formattedDataList[indexFirst] = .init(type: .addPhotoOrVideoCell(data),id: element.id)
                            indexPath = [.init(row: indexFirst, section: 0)]
                        } else {
                            formattedDataList[indexFirst] = .init(type: .addPhotoOrVideoCell(data),id: element.id)
                            indexPath = [.init(row: indexFirst, section: 0)]
                        }
                    }
                }
            default:
                break
            }
        }
    }
    
    //MARK: - Check box tapped function
    
    func checkBoxTapped(value: Bool) {
        for (index, element) in formattedDataList.enumerated() {
            switch element.type {
            case .sendReviewCell(var data):
                if value {
                    data.checkBox.image = "checkbox"
                    data.checkBox.isActive = false
                    formattedDataList[index] = .init(type: .sendReviewCell(data), id: element.id)
                    indexPath = [.init(row: index, section: 0)]
                } else {
                    data.checkBox.image = "checkbox.fill"
                    data.checkBox.isActive = true
                    formattedDataList[index] = .init(type: .sendReviewCell(data), id: element.id)
                    indexPath = [.init(row: index, section: 0)]
                }
            default:
                break
            }
        }
    }
    
    //MARK: - Send button function
    
    func sendButtonTapped() {
        for (index, element) in formattedDataList.enumerated() {
            switch element.type {
            case .productStarsCell(let data):
                if data.rating.currentRating == .none {
                    formattedDataList.insert(.init(type: .starsErrorCell(.init(errorLabel: Constants.StarsErrorCell.title.rawValue))), at: index + 1)
                    indexPath = []
                }
                return
            default:
                break
            }
        }
    }
}
