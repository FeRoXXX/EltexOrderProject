//
//  UserAgreementView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct UserAgreementView: View {
    var body: some View {
        HStack {
            Text(" Нажимая кнопку «Оформить заказ»,\nВы соглашаетесь с ")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)))
            +
            Text("Условиями оферты")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .background(Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)))
    }
}

