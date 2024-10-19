//
//  OrderInfoModuleAssembly.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 18.10.2024.
//

import UIKit

final class OrderInfoModuleAssembly {
    
    static func built(order: Order) -> UIViewController {
        let viewModel = OrderInfoViewModel(orderList: order)
        let controller = OrderInfoViewController(viewModel: viewModel)
        return controller
    }
}
