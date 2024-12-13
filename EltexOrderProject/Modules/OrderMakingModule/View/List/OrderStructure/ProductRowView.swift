//
//  ProductRowView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct ProductRowView: View {
    var body: some View {
        HStack(spacing: 0) {
            Image("ring")
                .clipShape(.capsule(style: .circular))
                .frame(maxHeight: .infinity, alignment: .top)
            VStack(spacing: 0) {
                Text("Золотое плоское обручальное кольцо 4 мм")
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 0) {
                    Text("1 шт. ")
                    Text("Размер: 17")
                    Spacer()
                }
                .font(.system(size: 14))
                .foregroundStyle(Color(#colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)))
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                HStack(spacing: 0) {
                    Text("32 217 Р")
                        .strikethrough(pattern: .solid)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(#colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)))
                    Text("-40%")
                        .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.2745098039, blue: 0.06666666667, alpha: 1)))
                        .padding(EdgeInsets(top: 1, leading: 4, bottom: 1, trailing: 4))
                        .background(Color(#colorLiteral(red: 1, green: 0.2745098039, blue: 0.06666666667, alpha: 0.1)))
                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 12, bottomLeading: 12, bottomTrailing: 12, topTrailing: 12)))
                        .padding(.leading, 6)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                Text("26 642,40Р")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 16))
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.bottom, 24)
    }
}
