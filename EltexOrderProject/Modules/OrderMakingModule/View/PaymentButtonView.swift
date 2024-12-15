//
//  PaymentButtonView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct PaymentButtonView: View {
    @State private var isActive = false
    
    var body: some View {
        VStack {
            Button {
                isActive = true
            } label: {
                Text("Оплатить")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    .frame(maxWidth: .infinity)
            }
            .background(Color(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)))
            .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 12, bottomLeading: 12, bottomTrailing: 12, topTrailing: 12)))
            NavigationLink("", destination: OrderResultView(), isActive: $isActive)
                .hidden()
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.bottom, 16)
        .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
    }
}
