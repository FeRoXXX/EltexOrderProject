//
//  SberScoresView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct SberScoresView: View {
    @State var score: Int
    var body: some View {
        HStack(spacing: 0) {
            Text(score.formattedSberScores())
                .foregroundStyle(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 2))
            Image("SberScores")
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
        }
        .background(Color(#colorLiteral(red: 0, green: 0.754624784, blue: 0.5331450701, alpha: 1)))
        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 10, bottomTrailing: 10, topTrailing: 10)))
    }
}
