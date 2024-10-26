//
//  ActivePromocodeModel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 25.10.2024.
//

import Foundation

struct ActivePromocodeModel {
    var type: ActivePromocodeViewModelType
    
    enum ActivePromocodeViewModelType {
        
        struct ActivePromocodeView {
            let buttonText: String
            let textFieldShouldBeginEditing: (() -> Void)?
            let activeButtonClicked: ((String?) -> Void)?
        }
        
        struct PromocodeTextField {
            let textFieldTitle: String
            let clearButtonClicked: (() -> Void)?
        }
        
        case view(ActivePromocodeView)
        case textField(PromocodeTextField)
    }
}
