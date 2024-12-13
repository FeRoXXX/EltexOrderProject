//
//  PaymentMethodView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct PaymentMethodView: View {
    @State var sberScoresActive: Bool
    @State var methodName: String
    @State var methodDescription: String
    
    var body: some View {
        HStack(spacing: 0) {
            Image("sber")
                .padding(.trailing, 12)
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(methodName)
                        .font(.system(size: 16, weight: .medium))
                    Text("-5%")
                        .foregroundStyle(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                        .background(Color(#colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)))
                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 32, bottomLeading: 32, bottomTrailing: 32, topTrailing: 32)))
                        .padding(.leading, 4)
                    if sberScoresActive {
                        SberScoresView()
                            .padding(.leading, 4)
                    }
                    Spacer()
                }
                Text(methodDescription)
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
