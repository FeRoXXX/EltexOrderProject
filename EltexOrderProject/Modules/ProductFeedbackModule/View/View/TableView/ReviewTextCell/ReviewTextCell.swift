//
//  ReviewTextCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import UIKit
import SnapKit

final class ReviewTextCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private let contentCellView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .next
        textField.delegate = self
        return textField
    }()
    
    //MARK: - Public properties
    
    var viewModel: ReviewTextCellModel? {
        didSet {
            updateData()
        }
    }
    
    var onReturnButtonClicked: ((UUID) -> Void)?
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extension

private extension ReviewTextCell {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(contentCellView)
        contentCellView.addSubview(textField)
    }
    
    func setupConstraints() {
        contentCellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(16)
        }
    }
    
    //MARK: - Update data function
    
    func updateData() {
        textField.placeholder = viewModel?.placeholder
        viewModel?.isFirstResponder?.bind({ [weak self] bool in
            switch bool ?? false {
            case true:
                self?.textField.becomeFirstResponder()
            case false:
                break
            }
        })
        if viewModel?.placeholder == "Комментарий" {
            textField.returnKeyType = .done
        } else {
            textField.returnKeyType = .next
        }
    }
}

//MARK: - UITextFieldDelegate

extension ReviewTextCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewModel?.isFirstResponder?.value = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel?.isFirstResponder?.value = false
        if textField.returnKeyType == .done {
            textField.resignFirstResponder()
        }
        onReturnButtonClicked?(viewModel?.id ?? UUID())
        return false
    }
}

//MARK: - Public extension

extension ReviewTextCell {
    
    //MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
}
