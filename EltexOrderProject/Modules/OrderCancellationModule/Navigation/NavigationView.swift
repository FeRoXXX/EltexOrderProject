//
//  NavigationView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.12.2024.
//

import SwiftUI

struct NavigationView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationStack(root: {
            OrderCancellationView()
                .navigationTitle("Укажите причину отмены")
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)))
                        }

                    }
                }
                .frame(maxWidth: .infinity)
                .navigationBarTitleDisplayMode(.inline)
        })
    }
}
