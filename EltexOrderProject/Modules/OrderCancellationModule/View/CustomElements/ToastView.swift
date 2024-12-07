//
//  ToastView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.12.2024.
//

import SwiftUI

struct ToastView: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("Заказ успешно отменен")
                .foregroundStyle(.white)
                .font(.system(size: 14))
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .background {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color(#colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 0.6)))
        }
    }
}
