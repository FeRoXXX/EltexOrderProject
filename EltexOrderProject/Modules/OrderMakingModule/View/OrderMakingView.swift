//
//  OrderMakingView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import SwiftUI

struct OrderMakingView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: OrderMakingViewModel = OrderMakingViewModel()
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.listData) { currentValue in
                    switch currentValue.type {
                    case .order(let orderList):
                        Section {
                            AdditionalTextView(additionalText: "Вы можете изменить параметры и состав заказа в ", textWithAnyColor: "корзине")
                            ForEach(orderList) { currentRow in
                                ProductRowView(product: currentRow)
                            }
                        } header: {
                            HeaderView(headerText: "Состав заказа")
                        }
                    case .payment(let paymentList):
                        Section {
                            ForEach(paymentList) { currentRow in
                                PaymentMethodView(method: currentRow, onSelect: {
                                    viewModel.setActivePaymentMethod(currentRow)
                                }, onCalculate: viewModel.calculatePrice)
                            }
                        } header: {
                            HeaderView(headerText: "Способы оплаты")
                        }
                    case .promoCode(let promocodeList):
                        Section {
                            AdditionalTextView(additionalText: "На один товар можно применить только один промокод")
                            ApplyPromocodeButtonView(viewModel: viewModel)
                            ForEach(promocodeList) { currentRow in
                                PromocodeView(promocode: currentRow, calculate: viewModel.calculatePrice)
                            }
                            HidePromocodeButtonView(hidePromocodes: viewModel.hidePromocodes)
                            PriceCountingView(isSupportButtonHidden: true, priceColor: .black, countingTitle: viewModel.priceAfterDiscount.numberOfProducts, price: $viewModel.priceAfterDiscount.totalPrice)
                                .padding(.top, 19)
                                .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
                            PriceCountingView(isSupportButtonHidden: true, priceColor: Color(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)), countingTitle: "Скидки", price: $viewModel.priceAfterDiscount.totalDiscount)
                            PriceCountingView(isSupportButtonHidden: false, priceColor: Color(#colorLiteral(red: 0, green: 0.754624784, blue: 0.5331450701, alpha: 1)), countingTitle: "Промокоды", price: $viewModel.priceAfterDiscount.totalPromoCode)
                            PriceCountingView(isSupportButtonHidden: true, priceColor: .black, countingTitle: "Способы оплаты", price: $viewModel.priceAfterDiscount.totalPaymentMethod)
                                .padding(.bottom, 11)
                                .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
                                .alignmentGuide(.listRowSeparatorLeading) { _ in
                                    return 16
                                }
                                .alignmentGuide(.listRowSeparatorTrailing) { viewDimensions in
                                    return viewDimensions.width - 16
                                }
                                .listRowSeparator(.visible)
                            ResultPriceView(resultPrice: $viewModel.priceAfterDiscount.totalResultPrice)
                            PaymentButtonView()
                            UserAgreementView()
                        } header: {
                            HeaderView(headerText: "Промокоды")
                        }
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
                .headerProminence(.increased)
            }
            .background(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
            .listStyle(.grouped)
            .buttonStyle(PlainButtonStyle())
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
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Ошибка"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
