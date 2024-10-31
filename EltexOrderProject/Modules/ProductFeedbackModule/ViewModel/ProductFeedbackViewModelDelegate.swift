//
//  ProductFeedbackViewModelDelegate.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import Foundation

protocol ProductFeedbackViewModelDelegate: AnyObject {
    
    func updateData(_ data: [ProductFeedbackTableModel])
}
