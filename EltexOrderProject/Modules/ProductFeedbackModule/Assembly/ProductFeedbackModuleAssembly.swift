//
//  ProductFeedbackModuleAssembly.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import UIKit

final class ProductFeedbackModuleAssembly {
    
    static func build(data: ProductTableModel) -> UIViewController {
        let viewModel = ProductFeedbackViewModel(receivedData: data)
        let controller = ProductFeedbackViewController(viewModel: viewModel)
        return controller
    }
}
