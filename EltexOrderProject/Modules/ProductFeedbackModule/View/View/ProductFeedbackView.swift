//
//  ProductFeedbackView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 30.10.2024.
//

import UIKit
import SnapKit

final class ProductFeedbackView: UIView {
    
    //MARK: - Private properties
    
    private let tableView: ProductFeedbackTableView = {
        let tableView = ProductFeedbackTableView()
        return tableView
    }()
    
    //MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc
    func keyboardWillAppear() {
        tableView.snp.removeConstraints()
        tableView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(keyboardLayoutGuide.layoutFrame.height)
        }
        layoutSubviews()
    }
    
    @objc
    func keyboardWillDisappear() {
        tableView.snp.removeConstraints()
        tableView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        layoutSubviews()
    }
}

//MARK: - Private extension

private extension ProductFeedbackView {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}

//MARK: - Public extension

extension ProductFeedbackView {
    
    //MARK: - Setup data functions
    
    func setupData(_ data: [ProductFeedbackTableModel]) {
        tableView.data = data
    }
    
    //MARK: - Setup indexPath function
    
    func setupIndexPath(indexPath: [IndexPath]?) {
        tableView.indexPath = indexPath
    }
}
