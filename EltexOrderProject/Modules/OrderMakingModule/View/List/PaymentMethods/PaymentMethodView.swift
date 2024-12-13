//
//  PaymentMethodView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct PaymentMethodView: View {
    @State var method: PaymentMethod
    
    var body: some View {
        HStack(spacing: 0) {
            Image(method.image)
                .padding(.trailing, 12)
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(method.title)
                        .font(.system(size: 16, weight: .medium))
                    Text(method.discount.formattedDiscount())
                        .foregroundStyle(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                        .background(Color(#colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)))
                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 32, bottomLeading: 32, bottomTrailing: 32, topTrailing: 32)))
                        .padding(.leading, 4)
                    if let sberScores = method.sberScores {
                        SberScoresView(score: sberScores)
                            .padding(.leading, 4)
                    }
                    Spacer()
                }
                Text(method.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
            Image("radio-button")
        }
        .padding(.top, 16)
        .padding(.bottom, 16)
        .padding(.leading, 32)
        .padding(.trailing, 32)
    }
}
