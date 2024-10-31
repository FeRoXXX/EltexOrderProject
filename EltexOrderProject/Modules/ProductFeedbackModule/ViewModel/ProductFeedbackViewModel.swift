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
    
    //MARK: - Public properties
    
    weak var delegate: ProductFeedbackViewModelDelegate? {
        didSet {
            delegate?.updateData(formattedDataList)
        }
    }
    
    //MARK: - Initialization
    
    init() {
        formattedDataList.append(.init(type: .productInfoCell(.init(title: "Золотое плоское обручальное кольцо 4 мм", description: "Размер: 17", imageName: "ringFirst"))))
        formattedDataList.append(.init(type: .productStarsCell(.init(title: "Хорошо"))))
        formattedDataList.append(.init(type: .addPhotoOrVideoEmptyCell(.init(title: "Добавьте фото или видео", description: "Нажмите, чтобы выбрать файлы"))))
        formattedDataList.append(.init(type: .reviewTextCell(.init(placeholder: "Достоинства"))))
        formattedDataList.append(.init(type: .reviewTextCell(.init(placeholder: "Недостатки"))))
        formattedDataList.append(.init(type: .reviewTextCell(.init(placeholder: "Комментарий"))))
        formattedDataList.append(.init(type: .sendReviewCell(.init(buttonTitle: "Отправить", userAgreement: "Перед отправкой отзыва, пожалуйста,\n ознакомьтесь с правилами публикации", checkBox: .init(title: "Оставить отзыв анонимно")))))
    }
}
