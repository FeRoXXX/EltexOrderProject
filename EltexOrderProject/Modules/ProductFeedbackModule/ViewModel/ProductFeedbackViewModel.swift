//
//  ProductFeedbackViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import Foundation

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
    
    func loadAndBuildFormattedData(placeholder: String, numberOfResponder: Int) {
        formattedDataList.append(.init(type: .reviewTextCell(.init(placeholder: placeholder, isFirstResponder: .init(false), changeFirstResponder: { [weak self] id in
            self?.changeFirstResponder(id: id)
        }))))
    }
    
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
    
    func formatReceivedDataFirst() {
        formattedDataList.append(.init(type: .productInfoCell(.init(title: receivedData.title, description: "Размер: 17", imageName: receivedData.imageName))))
        formattedDataList.append(.init(type: .productStarsCell(.init(title: "Ваша оценка", rating: .init(currentRating: .none, touchLocation: { [weak self] touch, value in
            self?.updateStarsRating(touch: touch, value: value)
        })))))
        formattedDataList.append(.init(type: .addPhotoOrVideoEmptyCell(.init(title: "Добавьте фото или видео", description: "Нажмите, чтобы добавить файл", cellIsTapped: { [weak self] in
            self?.addPhoto()
        }))))
        loadAndBuildFormattedData(placeholder: "Достоинства", numberOfResponder: 1)
        loadAndBuildFormattedData(placeholder: "Недостатки", numberOfResponder: 2)
        loadAndBuildFormattedData(placeholder: "Комментарий", numberOfResponder: 3)
        formattedDataList.append(.init(type: .sendReviewCell(.init(buttonTitle: "Отправить", userAgreement: "Перед отправкой отзыва, пожалуйста,\n ознакомьтесь с правилами публикации", checkBox: .init(title: "Оставить отзыв анонимно", isActive: false, image: "checkbox", checkBoxTapped: { [weak self] value in
            self?.checkBoxTapped(value: value)
        })))))
    }

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

    func createUpdateRatingCell(title: String? = nil, currentRating: ProductFeedbackTableModel.DataModel.ProductStarsCell.StarsRatingView.TapLocation) {
        findAndReplaceCell(typeData: .init(type: .productStarsCell(.init(title: title, rating: .init(currentRating: currentRating, touchLocation: { [weak self] touch, value in
            self?.updateStarsRating(touch: touch, value: value)
        })))))
    }
    
    func addPhoto() {
        for (index, element) in formattedDataList.enumerated() {
            switch element.type {
            case .addPhotoOrVideoEmptyCell(let data):
                formattedDataList[index] = .init(type: .addPhotoOrVideoCell(.init(cell: [.init(image: imageArray[0], cellIsTapped: data.cellIsTapped, deleteButtonTapped: { [weak self] id in
                    self?.deletePhoto(id: id)
                }), .init(image: nil, cellIsTapped: addPhoto, deleteButtonTapped: deletePhoto)])),id: element.id)
                indexPath = [.init(row: index, section: 0)]
            case .addPhotoOrVideoCell(var data):
                if data.cell.count != 7 {
                    data.cell.insert(.init(image: imageArray[data.cell.count - 1], cellIsTapped: addPhoto, deleteButtonTapped: { [weak self] id in
                        self?.deletePhoto(id: id)
                    }), at: data.cell.count - 1)
                    formattedDataList[index] = .init(type: .addPhotoOrVideoCell(data),id: element.id)
                    indexPath = [.init(row: index, section: 0)]
                } else {
                    data.cell.removeLast()
                    data.cell.append(.init(image: imageArray[imageArray.count - 1], cellIsTapped: addPhoto, deleteButtonTapped: { [weak self] id in
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
    
    func deletePhoto(id: UUID) {
        for (indexFirst, element) in formattedDataList.enumerated() {
            switch element.type {
            case .addPhotoOrVideoCell(var data):
                for (index, element) in data.cell.enumerated() {
                    if element.id == id {
                        data.cell.remove(at: index)
                        if data.cell.count == 1 {
                            formattedDataList[indexFirst] = .init(type: .addPhotoOrVideoEmptyCell(.init(title: "Добавьте фото или видео", description: "Нажмите, чтобы добавить файл", cellIsTapped: { [weak self] in
                                self?.addPhoto()
                            })))
                            indexPath = [.init(row: indexFirst, section: 0)]
                        } else if data.cell.count == 6 && data.cell.last != .init(image: nil, cellIsTapped: nil, deleteButtonTapped: nil) {
                            data.cell.append(.init(image: nil, cellIsTapped: addPhoto, deleteButtonTapped: { [weak self] id in
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
}
