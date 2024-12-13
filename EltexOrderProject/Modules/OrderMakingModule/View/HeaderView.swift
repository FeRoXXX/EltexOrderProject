//
//  HeaderView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct HeaderView: View {
    @State var headerText: String
    var body: some View {
        HStack() {
            Text(headerText)
                .padding(EdgeInsets(top: 24, leading: 16, bottom: 10, trailing: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}
