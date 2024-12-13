//
//  MainNavigationViewController.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import UIKit
import Combine
import SwiftUI

final class MainNavigationViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var contentView = MainNavigationView()
    private var viewModel: MainNavigationViewModel
    private var bindings: Set<AnyCancellable> = []
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Initialization
    
    init(viewModel: MainNavigationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extension

private extension MainNavigationViewController {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        self.view = contentView
    }
    
    //MARK: - Bindings
    
    func bind() {
        
        func bindViewToViewModel() {
            contentView.buttonTappedPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] value in
                    self?.viewModel.navigate(to: value)
                }
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.navigatePublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] value in
                    self?.navigation(to: value)
                }
                .store(in: &bindings)
        }
        
        bindViewModelToView()
        bindViewToViewModel()
    }
    
    //MARK: - Navigation
    
    func navigation(to view: MainNavigation) {
        switch view {
        case .inputPromocode:
            navigationController?.pushViewController(InputProductsViewController(), animated: true)
        case .review:
            navigationController?.pushViewController(FeedbackModuleAssembly.build(), animated: true)
        case .orderCancel:
            navigationController?.pushViewController(UIHostingController(rootView: OrderCancellationView()), animated: true)
        case .order:
            navigationController?.pushViewController(UIHostingController(rootView: OrderMakingView()), animated: true)
        }
    }
}