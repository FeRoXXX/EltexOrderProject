//
//  MainNavigationViewModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import Foundation
import Combine

enum MainNavigation: CaseIterable {
    case inputPromocode
    case review
    case orderCancel
    case order
    
    static func getNavigationType(by number: Int) -> MainNavigation {
        return self.allCases[number]
    }
}

final class MainNavigationViewModel {
    
    //MARK: - Private properties
    
    private(set) var navigatePublisher: PassthroughSubject<MainNavigation, Never> = .init()
}

//MARK: - Public extension

extension MainNavigationViewModel {
    
    //MARK: - Navigation
    
    func navigate(to numberOfView: Int) {
        navigatePublisher.send(MainNavigation.getNavigationType(by: numberOfView))
    }
}
