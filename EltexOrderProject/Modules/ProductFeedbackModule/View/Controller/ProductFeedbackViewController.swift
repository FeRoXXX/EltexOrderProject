//
//  ProductFeedbackViewController.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 30.10.2024.
//

import UIKit

final class ProductFeedbackViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let contentView = ProductFeedbackView()
    private let viewModel: ProductFeedbackViewModel
    
    //MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Initialization
    
    init(viewModel: ProductFeedbackViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private extension

private extension ProductFeedbackViewController {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        self.view = contentView
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = standard
        self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        title = "Напишите отзыв"
    }
}

//MARK: - ProductFeedbackViewModelDelegate

extension ProductFeedbackViewController: ProductFeedbackViewModelDelegate {
    
    func updateData(_ data: [ProductFeedbackTableModel]) {
        contentView.setupData(data)
    }
    
    func setupTableViewModel(_ data: ProductFeedbackModel?) {
        contentView.setupTableViewModel(data)
    }
}
