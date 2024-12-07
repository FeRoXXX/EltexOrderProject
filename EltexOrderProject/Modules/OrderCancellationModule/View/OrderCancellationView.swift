//
//  OrderCancellationView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 06.12.2024.
//

import SwiftUI


struct OrderCancellationView: View {
    @State var activeCell: UUID?
    @State var inputText: String = ""
    @State var isLoading: Bool = false
    @State var toastShow: Bool = false
    @ObservedObject var viewModel = OrderCancellationViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(viewModel.data) { value in
                        switch value.type {
                        case .error(let text):
                            SelectionErrorView(text: text)
                        case .checkRow(let text, let isAny):
                            ToggleReasonView(text: text,
                                             viewModel: viewModel,
                                             activeCell: $activeCell,
                                             id: value.id,
                                             isAny: isAny)
                        case .cancelButton(let text):
                            CancellationButtonView(text: text,
                                                   buttonTapped:
                                                    Binding(get: {
                                return false
                            }, set: { value in
                                if value {
                                    if activeCell != nil {
                                        viewModel.cancelOrder()
                                        isLoading = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: DispatchWorkItem(block: {
                                            isLoading = false
                                            toastShow = true
                                            self.activeCell = nil
                                            inputText = ""
                                            viewModel.prepareProblemDescription(isOther: false)
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: DispatchWorkItem(block: {
                                                withAnimation {
                                                    toastShow = false
                                                }
                                            }))
                                        }))
                                    } else {
                                        withAnimation {
                                            viewModel.showErrorCell()
                                        }
                                    }
                                }
                            }))
                        case .problemDescriptionTextField(let text):
                            ProblemDescriptionView(inputText: inputText, placeholder: text)
                        case .screenDescription(let text):
                            AdditionalDescriptionView(text: text)
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollDismissesKeyboard(.interactively)
            }
            if isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
            
            if toastShow {
                VStack {
                    Spacer()
                    ToastView()
                        .padding(.bottom, 32)
                }
            }
        }
    }
}
