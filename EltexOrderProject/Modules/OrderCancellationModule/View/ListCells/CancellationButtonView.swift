//
//  CancellationButtonView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.12.2024.
//

import SwiftUI

struct CancellationButtonView: View {
    var text: String
    @Binding var buttonTapped: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Button(text) {
                buttonTapped = true
            }
            .font(.system(size: 16, weight: .bold))
            .padding(.top, 16)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)
            .buttonBorderShape(.roundedRectangle(radius: 12))
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(#colorLiteral(red: 1, green: 0.2745098039, blue: 0.06666666667, alpha: 1)))
            }
            .foregroundStyle(.white)
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
        .listRowSeparator(.hidden)
    }
}
