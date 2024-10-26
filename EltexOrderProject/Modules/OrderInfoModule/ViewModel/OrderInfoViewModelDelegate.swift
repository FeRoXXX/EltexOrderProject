//
//  OrderInfoViewModelDelegate.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 18.10.2024.
//

import Foundation

protocol OrderInfoViewModelDelegate: AnyObject {
    func activateSnackBar(_ text: String)
    func deactivateSnackBar()
    func openActivePromocode(_ data: [Order.Promocode])
    func cellDidChange(_ data: [OrderInfoTableViewModel])
    func showAlert(message: String)
    func setTitle(_ title: String)
    func insertRows(at indexes: [IndexPath], data: [OrderInfoTableViewModel])
    func deleteRows(at indexes: [IndexPath], data: [OrderInfoTableViewModel])
    func reloadCell(at indexes: [IndexPath], data: [OrderInfoTableViewModel])
}
