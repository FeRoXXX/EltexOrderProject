//
//  ToolbarBackgroundModifier.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct ToolbarBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available (iOS 18.0, *) {
            content
                .toolbarBackground(.white, for: .navigationBar)
                .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        } else {
            content
                .toolbarBackground(.white, for: .navigationBar)
                .onAppear {
                    
                    UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
                    UINavigationBar.appearance().scrollEdgeAppearance?.backgroundColor = UIColor.white
                }
        }
    }
}
