//
//  AdditionalTextView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct AdditionalTextView: View {
    @State var additionalText: String
    @State var textWithAnyColor: String?
    var body: some View {
        HStack {
            if let textWithAnyColor {
                Text(additionalText)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)))
                +
                Text(textWithAnyColor)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.2745098039, blue: 0.06666666667, alpha: 1)))
            } else {
                Text(additionalText)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)))
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.bottom, 16)
    }
}

