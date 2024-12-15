//
//  HidePromocodesButtonView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct HidePromocodeButtonView: View {
    @State var hidePromocodes: (() -> Void)?
    var body: some View {
        Button("Скрыть промокоды") {
            withAnimation {
                hidePromocodes?()
            }
        }
        .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.2745098039, blue: 0.06666666667, alpha: 1)))
        .padding(.top, 13)
        .padding(.bottom, 33)
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
}
