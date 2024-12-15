//
//  PriceCountingView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct PriceCountingView: View {
    @State var isSupportButtonHidden: Bool = true
    @State var priceColor: Color
    @State var countingTitle: String
    @Binding var price: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text(countingTitle)
                .padding(.trailing, 4)
            if !isSupportButtonHidden {
                Button {
                    
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(Color(#colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)))
                }
            }
            Spacer()
            Text(price)
                .foregroundStyle(priceColor)
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.bottom, 5)
        .padding(.top, 5)
        .frame(maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
    }
}
