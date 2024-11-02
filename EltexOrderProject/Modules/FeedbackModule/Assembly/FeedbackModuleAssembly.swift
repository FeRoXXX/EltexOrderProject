//
//  FeedbackModuleAssembly.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 30.10.2024.
//

import UIKit

final class FeedbackModuleAssembly {
    
    static func build() -> UIViewController {
        
        let viewModel = FeedbackViewModel(data: [
            .init(imageName: "ringFirst", title: "Золотое плоское обручальное кольцо 4 мм"),
            .init(imageName: "ringSecond", title: "Золотое плоское обручальное кольцо 4 мм"),
            .init(imageName: "ringThird", title: "Золотое плоское обручальное кольцо 4 мм"),
            .init(imageName: "ringFourth", title: "Золотое плоское обручальное кольцо 4 мм")])
        let viewController = FeedbackViewController(viewModel: viewModel)
        return viewController
    }
}
