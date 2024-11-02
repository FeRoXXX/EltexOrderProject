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
    
    private var productTableView: ProductTableView = {
        let tableView = ProductTableView()
        return tableView
    }()
    
    //MARK: - Public properties
    
    var cellDidChange: ((Int) -> Void)?
    
    //MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupClosures()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    //MARK: - Closures initialization
    
    func setupClosures() {
        productTableView.cellDidSelect = { [weak self] index in
            self?.cellDidChange?(index)
        }
    }
}

//MARK: - Extension

extension FeedbackView {
    
    func setupData(_ data: [ProductTableModel]) {
        productTableView.viewModel = data
    }
}
