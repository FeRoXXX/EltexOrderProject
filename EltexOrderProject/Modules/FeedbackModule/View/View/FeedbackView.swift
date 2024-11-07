//
//  FeedbackView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 29.10.2024.
//

import UIKit
import SnapKit

final class FeedbackView: UIView {
    
    //MARK: - Private properties
    
    private lazy var productTableView: ProductTableView = {
        let tableView = ProductTableView()
        return tableView
    }()
    
    private var viewModel: FeedbackViewModelInput
    
    //MARK: - Initialization
    
    init(viewModel: FeedbackViewModelInput) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        self.productTableView.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Table reload function
    
    func reloadTable() {
        productTableView.reloadData()
    }
}

//MARK: - Private extension

private extension FeedbackView {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(productTableView)
    }
    
    func setupConstraints() {
        productTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}
