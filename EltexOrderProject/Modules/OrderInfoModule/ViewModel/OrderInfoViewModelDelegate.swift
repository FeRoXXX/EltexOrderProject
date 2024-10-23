//
//  OrderInfoViewModelDelegate.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 18.10.2024.
//

import Foundation

protocol OrderInfoViewModelDelegate: AnyObject {
    func cellDidChange(_ data: [OrderInfoTableViewModel])
    func showAlert(message: String)
    func setTitle(_ title: String)
    func reloadCell(at indexes: [IndexPath], data: [OrderInfoTableViewModel])
}
