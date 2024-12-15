//
//  ApplyPromocodeButtonView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct ApplyPromocodeButtonView: View {
    @ObservedObject var viewModel: OrderMakingViewModel
    @State private var isActive = false

    var body: some View {
        VStack {
            Button(action: {
                isActive = true
            }) {
                HStack(spacing: 0) {
                    Image("Promocode")
                        .padding(.trailing, 10)
                    Text("Применить промокод")
                        .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)))
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 16)
                .padding(.bottom, 16)
                .background(Color(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 0.1)))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.bottom, 8)
            }
            .buttonStyle(PlainButtonStyle())

            NavigationLink("", destination: ActivePromocodeView(viewModel: viewModel), isActive: $isActive)
                .hidden()
        }
    }
}
