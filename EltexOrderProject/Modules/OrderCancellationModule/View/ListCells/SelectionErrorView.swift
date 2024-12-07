//
//  SelectionErrorView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.12.2024.
//

import SwiftUI

struct SelectionErrorView: View {
    var text: String
    var body: some View {
        HStack(spacing: 16) {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 0))
                .foregroundStyle(Color(#colorLiteral(red: 0.9758322835, green: 0.2742320597, blue: 0.2279928625, alpha: 1)))
                .font(.system(size: 14))
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 14))
                .foregroundStyle(Color(#colorLiteral(red: 0.9758322835, green: 0.2742320597, blue: 0.2279928625, alpha: 1)))
        }
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(#colorLiteral(red: 1, green: 0.9254901961, blue: 0.9254901961, alpha: 1)))
        }
        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
        .listRowSeparator(.hidden)
    }
}
