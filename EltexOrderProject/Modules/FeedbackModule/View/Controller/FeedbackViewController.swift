//
//  FeedbackViewController.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 29.10.2024.
//

import UIKit

final class FeedbackViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let feedbackView: FeedbackView = .init()
    private let viewModel: FeedbackViewModel
    
    //MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupClosures()
    }
    
    //MARK: - Initialization
    
    init(viewModel: FeedbackViewModel) {
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

private extension FeedbackViewController {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        self.view = feedbackView
        setupTitle()
    }
    
    func setupTitle() {
        self.title = "Напишите отзыв"
    }
    
    func setupClosures() {
        feedbackView.cellDidChange = { [weak self] index in
            self?.viewModel.cellDidChange(index)
        }
    }
}

//MARK: - ViewModelDelegate
extension FeedbackViewController: FeedbackViewModelDelegate {
    
    func setupData(_ data: [ProductTableModel]) {
        feedbackView.setupData(data)
    }
    
    func useNavigation(_ navigation: Navigation) {
        switch navigation {
        case .currentController:
            return
        case .nextController:
            self.navigationController?.pushViewController(ProductFeedbackModuleAssembly.build(), animated: true)
        }
    }
}
