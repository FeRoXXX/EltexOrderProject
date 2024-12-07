//
//  AdditionalDescriptionView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.12.2024.
//

import SwiftUI

struct AdditionalDescriptionView: View {
    var text: String
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 0))
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.top, 14)
                .padding(.trailing, 16)
                .foregroundStyle(Color(#colorLiteral(red: 0.9725490196, green: 0.7764705882, blue: 0.137254902, alpha: 1)))
        }
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(#colorLiteral(red: 0.9960784314, green: 0.968627451, blue: 0.8705882353, alpha: 1)))
        }
        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
        .listRowSeparator(.hidden)
    }
}
