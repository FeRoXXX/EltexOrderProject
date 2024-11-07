//
//  ProductFeedbackViewModelOutput.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.11.2024.
//

import Foundation

protocol ProductFeedbackViewModelOutput {
    
    //MARK: - Observer of the complete table update
    var onDataReload: Observable<Bool> { get set }
    
    //MARK: - Observer of the concrete cell update
    var onCellReloadAtIndex: Observable<IndexPath> {get set}
    
    //MARK: - Observer for adding a cell by index
    var onCellInsertAtIndex: Observable<IndexPath> {get set}
    
    //MARK: - Observer for deleting a cell by index
    var onCellDeleteAtIndex: Observable<IndexPath> {get set}
}
