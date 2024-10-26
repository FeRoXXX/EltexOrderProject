//
//  ActivePromocodeViewModelDelegate.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 25.10.2024.
//

import Foundation

protocol ActivePromocodeViewModelDelegate: AnyObject {
    func clearTextField()
    func makeAlert(_ text: String)
    func hideAlert()
    func setData(_ data: ActivePromocodeModel)
    func setupTitle(_ title: String)
    func closeWindow()
}
