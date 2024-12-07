//
//  ProblemDescriptionView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.12.2024.
//

import SwiftUI

struct ProblemDescriptionView: View {
    @State var inputText: String
    var placeholder: String
    
    var body: some View {
        HStack {
            TextField("", text: $inputText, prompt: Text(placeholder).foregroundStyle(Color(#colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1))).font(.system(size: 16)))
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        }
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
        }
        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
        .listRowSeparator(.hidden)
    }
}
