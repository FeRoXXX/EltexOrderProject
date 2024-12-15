//
//  ResultPriceView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct ResultPriceView: View {
    @Binding var resultPrice: String
    var body: some View {
        HStack(spacing: 0) {
            Text("Итог")
                .font(.system(size: 18, weight: .heavy))
            Spacer()
            Text(resultPrice)
                .font(.system(size: 18, weight: .heavy))
        }
        .padding(.trailing, 16)
        .padding(.leading, 16)
        .padding(.top, 16)
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
    }
}
