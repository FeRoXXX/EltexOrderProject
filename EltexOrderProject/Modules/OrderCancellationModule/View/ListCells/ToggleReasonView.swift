//
//  ToggleReasonView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.12.2024.
//

import SwiftUI

struct ToggleReasonView: View {
    var text: String
    var viewModel: OrderCancellationViewModel
    @Binding var activeCell: UUID?
    var id: UUID
    var isAny: Bool
    
    var isOn: Bool {
        if let activeCell {
            return activeCell == id
        } else {
            return false
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(isOn ? "checkbox.fill" : "checkbox")
                .foregroundStyle(.black)
            Text(text)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
        }
        .listRowInsets(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
        .listRowSeparator(.hidden)
        .onTapGesture {
            activeCell = id
            withAnimation {
                viewModel.prepareProblemDescription(isOther: isAny)
                viewModel.hideErrorCell()
            }
        }
    }
}
