//
//  ActivePromocodeModuleAssembly.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 25.10.2024.
//

import UIKit

final class ActivePromocodeModuleAssembly {
    static func build(_ order: [Order.Promocode], _ viewModel: OrderInfoViewModel? = nil, _ previousScreen: OrderMakingViewModel?) -> UIViewController {
        if let previousScreen {
            let viewModel = ActivePromocodeViewModel(promoCodesList: order, previousViewModel: viewModel, viewModel: previousScreen)
            let controller = ActivatePromocodeViewController(viewModel: viewModel)
            return controller
        } else {
            let viewModel = ActivePromocodeViewModel(promoCodesList: order, previousViewModel: viewModel)
            let controller = ActivatePromocodeViewController(viewModel: viewModel)
            return controller
        }
    }
}
