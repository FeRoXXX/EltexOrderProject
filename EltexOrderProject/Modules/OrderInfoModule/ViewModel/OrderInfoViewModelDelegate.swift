//
//  OrderInfoViewModelDelegate.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 18.10.2024.
//

import Foundation

protocol OrderInfoViewModelDelegate: AnyObject {
    func cellDidChange(_ data: [OrderInfoTableViewModel])
}
