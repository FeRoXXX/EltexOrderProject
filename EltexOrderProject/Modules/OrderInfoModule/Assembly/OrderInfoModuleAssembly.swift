//
//  OrderInfoModuleAssembly.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 18.10.2024.
//

import UIKit

final class OrderInfoModuleAssembly {
    
    static func built() -> UIViewController {
        let viewModel = OrderInfoViewModel()
        let controller = OrderInfoViewController(viewModel: viewModel)
        return controller
    }
}
