//
//  FeedbackViewController.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 29.10.2024.
//

import UIKit

final class FeedbackViewController: UIViewController {
    
    //MARK: - Private properties
    
    private lazy var feedbackView: FeedbackView = FeedbackView(viewModel: viewModel)
    private let viewModel: FeedbackViewModelInput & FeedbackViewModelOutput
    
    //MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    //MARK: - Initialization
    
    init(viewModel: FeedbackViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private extension

private extension FeedbackViewController {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        self.view = feedbackView
        setupTitle()
    }
    
    func setupTitle() {
        self.title = "Напишите отзыв"
    }
    
    //MARK: - Bindings
    
    func bind() {
        viewModel.onNavigateToNext.bind { [weak self] value in
            guard let value else { return }
            self?.navigationController?.pushViewController(ProductFeedbackModuleAssembly.build(data: value), animated: true)
        }
        
        viewModel.onReloadTableView.bind { [weak self] value in
            guard value != nil else { return }
            self?.feedbackView.reloadTable()
        }
    }
}
