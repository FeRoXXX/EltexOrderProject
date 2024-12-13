//
//  OrderMakingView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct OrderMakingView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            List {
                Section(content: {
                    AdditionalTextView(additionalText: "Вы можете изменить параметры и состав заказа в корзине")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    ProductRowView()
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    ProductRowView()
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }, header: {
                    HeaderView(headerText: "Состав заказа")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                })
                .listRowSeparator(.hidden)
                .headerProminence(.increased)
                Section(content: {
                    PaymentMethodView(sberScoresActive: true, methodName: "SberPay", methodDescription: "Через приложение банка")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PaymentMethodView(sberScoresActive: false, methodName: "Банковской картой", methodDescription: "Visa, Master Card, МИР")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PaymentMethodView(sberScoresActive: false, methodName: "Яндекс Пэй со Сплитом", methodDescription: "Оплата частями")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PaymentMethodView(sberScoresActive: false, methodName: "Рассрочка Тинькофф", methodDescription: "На 3 месяца без переплат")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PaymentMethodView(sberScoresActive: false, methodName: "Tinkoff Pay", methodDescription: "Через приложение Тинькофф")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PaymentMethodView(sberScoresActive: false, methodName: "Оплата при получении", methodDescription: "Наличными или картой")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .padding(.bottom, 20)
                }, header: {
                    HeaderView(headerText: "Способы оплаты")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                })
                .listRowSeparator(.hidden)
                .headerProminence(.increased)
                Section {
                    AdditionalTextView(additionalText: "На один товар можно применить только один промокод")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    ApplyPromocodeButtonView()
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PromocodeView(promocodeName: "SECRETCODE", promocodeDate: "По 31 марта", promocodeDescription: nil)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PromocodeView(promocodeName: "HELLO", promocodeDate: "По 31 марта", promocodeDescription: "Промокод действует на первый заказ")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PromocodeView(promocodeName: "VESNA23", promocodeDate: "По 31 марта", promocodeDescription: "Промокод действует для заказов от 30 000 Р")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    HidePromocodeButtonView()
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PriceCountingView(isSupportButtonHidden: true, priceColor: .black, countingTitle: "Цена за 2 товара", price: "25 000 P")
                        .padding(.top, 19)
                        .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PriceCountingView(isSupportButtonHidden: true, priceColor: Color(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)), countingTitle: "Скидки", price: "-5 000 P")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PriceCountingView(isSupportButtonHidden: false, priceColor: Color(#colorLiteral(red: 0, green: 0.754624784, blue: 0.5331450701, alpha: 1)), countingTitle: "Промокоды", price: "-5 000 P")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PriceCountingView(isSupportButtonHidden: true, priceColor: .black, countingTitle: "Способы оплаты", price: "-5 000 P")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .padding(.bottom, 11)
                        .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
                        .alignmentGuide(.listRowSeparatorLeading) { _ in
                            return 16
                        }
                        .alignmentGuide(.listRowSeparatorTrailing) { viewDimensions in
                            return viewDimensions.width - 16
                        }
                        .listRowSeparator(.visible)
                    ResultPriceView(resultPrice: "19 000 P")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    PaymentButtonView()
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    UserAgreementView()
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                } header: {
                    HeaderView(headerText: "Промокоды")
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listRowSeparator(.hidden)
                .headerProminence(.increased)
                
            }
            .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
            .listStyle(.grouped)
            .environment(\.defaultMinListRowHeight, 20)
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Оформление заказа")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)))
                }
            }
        }
        .modifier(ToolbarBackgroundModifier())
    }
}
