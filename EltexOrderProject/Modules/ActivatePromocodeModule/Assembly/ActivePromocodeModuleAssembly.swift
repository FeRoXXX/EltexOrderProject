//
//  ActivePromocodeModuleAssembly.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 25.10.2024.
//

import UIKit

final class ActivePromocodeModuleAssembly {
    static func build(_ order: [Order.Promocode], _ viewModel: OrderInfoViewModel) -> UIViewController {
        let viewModel = ActivePromocodeViewModel(promoCodesList: order, previousViewModel: viewModel)
        let controller = ActivatePromocodeViewController(viewModel: viewModel)
        return controller
    }
}
