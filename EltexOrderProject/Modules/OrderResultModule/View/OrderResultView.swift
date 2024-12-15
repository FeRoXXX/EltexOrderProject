//
//  OrderResultView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 15.12.2024.
//

import SwiftUI

struct OrderResultView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: OrderResultViewModel = OrderResultViewModel()
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                Image(viewModel.viewData.image)
                    .frame(width: 72, height: 72)
                    .padding(.bottom, 24)
                Text(viewModel.viewData.result)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.center)
                Text(viewModel.viewData.description)
                    .font(.system(size: 14))
                    .foregroundStyle(Color(#colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)))
                    .padding(.bottom, 24)
                    .multilineTextAlignment(.center)
                Button {
                } label: {
                    Text(viewModel.viewData.buttonText)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.bottom, 24)
                if let statusButton = viewModel.viewData.statusButton {
                    Button {
                    } label: {
                        Text(statusButton)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)))
                    }
                }
            }
            .padding(.horizontal, 47.5)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
