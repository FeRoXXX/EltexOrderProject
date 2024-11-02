//
//  FeedbackViewModelDelegate.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 30.10.2024.
//

import Foundation

protocol FeedbackViewModelDelegate: AnyObject {
    func setupData(_ data: [ProductTableModel])
    func useNavigation(_ navigation: Navigation, data: ProductTableModel?)
}
