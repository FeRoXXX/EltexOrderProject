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
    
    private lazy var tableView: ProductFeedbackTableView = {
        let tableView = ProductFeedbackTableView(viewModel: viewModel)
        return tableView
    }()
    
    //MARK: - Public properties
    
    var viewModel: ProductFeedbackViewModelInput & ProductFeedbackViewModelOutput
    
    //MARK: - Initialization
    
    init(viewModel: ProductFeedbackViewModelInput & ProductFeedbackViewModelOutput) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //MARK: - Keyboard visible functions
    
    @objc
    func keyboardWillAppear(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        let keyboardHeight = keyboardFrame.height

        tableView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(keyboardHeight)
        }

        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: animationCurve << 16),
                       animations: {
                           self.layoutIfNeeded()
                           self.tableView.setContentOffset(.init(x: 0, y: self.tableView.contentSize.height - self.tableView.bounds.size.height), animated: false)
                       },
                       completion: nil)
    }
    
    @objc
    func keyboardWillDisappear() {
        tableView.snp.removeConstraints()
        tableView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}

//MARK: - Private extension

private extension ProductFeedbackView {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubviews()
        setupConstraints()
        setupBinds()
    }
    
    func addSubviews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    //MARK: - Setup bindings
    
    func setupBinds() {
        viewModel.onDataReload.bind { [weak self] value in
            guard value != nil else { return }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.viewModel.onDataReload.value = nil
            }
        }
        
        viewModel.onCellReloadAtIndex.bind { [weak self] value in
            guard let value else { return }
            DispatchQueue.main.async {
                self?.tableView.reloadRows(at: [value], with: .automatic)
                self?.viewModel.onCellReloadAtIndex.value = nil
            }
        }
        
        viewModel.onCellInsertAtIndex.bind { [weak self] value in
            guard let value,
                let self else { return }
            DispatchQueue.main.async {
                self.tableView.insertRows(at: [value], with: .automatic)
                self.viewModel.onCellInsertAtIndex.value = nil
            }
        }
        
        viewModel.onCellDeleteAtIndex.bind { [weak self] value in
            guard let value,
                let self else { return }
            DispatchQueue.main.async {
                self.tableView.deleteRows(at: [value], with: .automatic)
                self.viewModel.onCellDeleteAtIndex.value = nil
            }
        }
    }
}
