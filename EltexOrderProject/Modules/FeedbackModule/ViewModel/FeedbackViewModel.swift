//
//  FeedbackViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 30.10.2024.
//

import Foundation

final class FeedbackViewModel: FeedbackViewModelInput {
    
    //MARK: - Private properties
    
    var onReloadTableView: Observable<Bool> = Observable(nil)
    var onNavigateToNext: Observable<ProductTableModel> = Observable(nil)
    var data: [ProductTableModel]
    
    //MARK: - Initialization
    
    init(data: [ProductTableModel]) {
        self.data = data
    }
}

//MARK: - FeedbackViewModelInput

extension FeedbackViewModel: FeedbackViewModelOutput {
    
    func cellDidChange(_ index: Int) {
        onNavigateToNext.value = data[index]
    }
}
