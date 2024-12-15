//
//  ActivePromocodeView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 14.12.2024.
//

import SwiftUI

struct ActivePromocodeView: View {
    @ObservedObject var viewModel: OrderMakingViewModel
    
    var body: some View {
        ActivePromocodeViewControllerWrapper(viewModel: viewModel)
            .ignoresSafeArea()
    }
}
