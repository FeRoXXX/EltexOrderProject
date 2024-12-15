//
//  ActivePromocodeViewControllerWrapper.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 15.12.2024.
//

import SwiftUI

struct ActivePromocodeViewControllerWrapper: UIViewControllerRepresentable {
    @ObservedObject var viewModel: OrderMakingViewModel
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return ActivePromocodeModuleAssembly.build([
            .init(title: "4120499", percent: 70, endDate: .now, info: "Promocode to product", active: true),
            .init(title: "4120339", percent: 20, endDate: .now, info: nil, active: true),
        ], nil, viewModel)
    }
}

