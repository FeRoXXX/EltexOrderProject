//
//  FeedbackViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 30.10.2024.
//

import Foundation

enum Navigation {
    case currentController
    case nextController
}

final class FeedbackViewModel {
    
    //MARK: - Private properties
    
    private var data: [ProductTableModel] {
        didSet {
            delegate?.setupData(data)
        }
    }
    
    private var navigation: Navigation = .currentController {
        didSet {
            delegate?.useNavigation(navigation, data: selectData)
        }
    }
    private var selectData: ProductTableModel?
    
    weak var delegate: FeedbackViewModelDelegate? {
        didSet {
            delegate?.setupData(data)
        }
    }
    
    //MARK: - Initialization
    
    init(data: [ProductTableModel]) {
        self.data = data
    }
    
    //MARK: - Public methods
    
    func cellDidChange(_ index: Int) {
        selectData = data[index]
        navigation = .nextController
        selectData = nil
    }
}
