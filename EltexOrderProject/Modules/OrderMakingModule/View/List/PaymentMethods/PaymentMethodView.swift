//
//  PaymentMethodView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct PaymentMethodView: View {
    @State var method: PaymentMethod
    var onSelect: (() -> Void)?
    var onCalculate: ((PromoCode?) -> Void)?
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(method.image)
                    .padding(.trailing, 12)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(method.title)
                            .font(.system(size: 16, weight: .medium))
                        if method.discount != 0 {
                            Text(method.discount.formattedDiscount())
                                .foregroundStyle(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                                .background(Color(#colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)))
                                .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 32, bottomLeading: 32, bottomTrailing: 32, topTrailing: 32)))
                                .padding(.leading, 4)
                        }
                        if let sberScores = method.sberScores {
                            SberScoresView(score: sberScores)
                                .padding(.leading, 4)
                        }
                        Spacer()
                    }
                    Text(method.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(#colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)))
                }
                Spacer()
                if method.isActive {
                    Image("radio-button.fill")
                } else {
                    Image("radio-button")
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 12)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .onTapGesture {
                withAnimation {
                    onSelect?()
                    onCalculate?(nil)
                }
            }
            .background(
                Group {
                    if method.isActive {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 0)
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    }
                }
            )
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
}
