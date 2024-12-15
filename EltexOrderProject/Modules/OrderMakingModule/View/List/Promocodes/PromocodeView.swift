//
//  PromocodeView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct PromocodeView: View {
    @ObservedObject var promocode: PromoCode
    var calculate: ((PromoCode) -> Void)?
    var body: some View {
        HStack {
            Circle()
                .trim(from: 0, to: 0.5)
                .rotation(Angle(radians: 1.5 * .pi))
                .fill(.white)
                .frame(width: 16, height: 16)
                .padding(.leading, -8)
            VStack(spacing: 0) {
                HStack(spacing: 4) {
                    Text(promocode.title)
                        .font(.system(size: 16, weight: .medium))
                        .layoutPriority(1)
                    Text(promocode.percent.formattedDiscount())
                        .foregroundStyle(.white)
                        .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                        .background(Color(#colorLiteral(red: 0, green: 0.7176470588, blue: 0.4588235294, alpha: 1)))
                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 32, bottomLeading: 32, bottomTrailing: 32, topTrailing: 32)))
                        .frame(minWidth: 50)
                    Button {
                        
                    } label: {
                        Image("Info")
                            .resizable()
                            .foregroundStyle(Color(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)))
                    }
                    .frame(width: 20, height: 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Text(promocode.date)
                    .font(.system(size: 14))
                    .foregroundStyle(Color(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                if let promocodeDescription = promocode.description {
                    Text(promocodeDescription)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 4)
            Toggle(isOn: $promocode.isActive) {
            }
            .tint(Color(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)))
            .onChange(of: promocode.isActive) {
                calculate?(promocode)
            }
            .frame(maxWidth: 42)
            .padding(.trailing, 12)
            Circle()
                .trim(from: 0, to: 0.5)
                .rotation(Angle(radians: .pi / 2))
                .fill(.white)
                .frame(width: 16, height: 16)
                .padding(.trailing, -8)
        }
        .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
        .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
        .frame(maxWidth: .infinity)
        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 12, bottomLeading: 12, bottomTrailing: 12, topTrailing: 12)))
        .padding(.top, 8)
        .padding(.bottom, 8)
        .padding(.leading, 16)
        .padding(.trailing, 16)
        
    }
}
