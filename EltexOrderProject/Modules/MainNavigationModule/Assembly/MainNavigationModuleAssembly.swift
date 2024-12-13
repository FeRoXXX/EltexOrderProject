//
//  MainNavigationModuleAssembly.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import UIKit

final class MainNavigationModuleAssembly {
    
    //MARK: - Build view controller
    
    static func build() -> UIViewController {
        let viewModel = MainNavigationViewModel()
        let viewController = MainNavigationViewController(viewModel: viewModel)
        return viewController
    }
}
