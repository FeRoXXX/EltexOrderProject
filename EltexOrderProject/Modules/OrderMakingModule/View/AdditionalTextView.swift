//
//  AdditionalTextView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct AdditionalTextView: View {
    @State var additionalText: String
    var body: some View {
        HStack {
            Text(additionalText)
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.bottom, 16)
    }
}

