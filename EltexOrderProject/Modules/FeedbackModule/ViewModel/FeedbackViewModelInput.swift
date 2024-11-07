//
//  FeedbackViewModelInput.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.11.2024.
//

import Foundation

protocol FeedbackViewModelInput {
    
    //MARK: - For concrete cell tapped
    func cellDidChange(_ index: Int)
    
    //MARK: - tableView data
    var data: [ProductTableModel] { get set }
}
