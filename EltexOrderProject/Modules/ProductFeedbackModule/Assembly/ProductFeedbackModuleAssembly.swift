//
//  ProductFeedbackModuleAssembly.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import UIKit

final class ProductFeedbackModuleAssembly {
    
    static func build() -> UIViewController {
        let viewModel = ProductFeedbackViewModel()
        let controller = ProductFeedbackViewController(viewModel: viewModel)
        return controller
    }
}
