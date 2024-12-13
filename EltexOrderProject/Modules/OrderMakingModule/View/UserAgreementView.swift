//
//  UserAgreementView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct UserAgreementView: View {
    var body: some View {
        Text(" Нажимая кнопку «Оформить заказ»,\nВы соглашаетесь с Условиями оферты")
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
    }
}

