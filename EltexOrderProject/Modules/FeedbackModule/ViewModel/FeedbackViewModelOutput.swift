//
//  FeedbackViewModelOutput.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.11.2024.
//

import Foundation

protocol FeedbackViewModelOutput {
    
    //MARK: - Observer of the complete table update
    var onReloadTableView: Observable<Bool> { get }
    
    //MARK: - Observer for navigation to next view
    var onNavigateToNext: Observable<ProductTableModel> { get }
}
