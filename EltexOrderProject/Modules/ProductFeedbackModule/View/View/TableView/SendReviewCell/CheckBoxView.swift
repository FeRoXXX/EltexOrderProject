//
//  CheckBoxView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import UIKit
import SnapKit

final class CheckBoxView: UIView {
    
    //MARK: - Private properties
    
    private let checkBoxImageView: UIImageView = {
        let checkBoxImageView = UIImageView()
        checkBoxImageView.image = .checkbox
        checkBoxImageView.contentMode = .scaleAspectFit
        return checkBoxImageView
    }()
    
    private let additionalTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Оставить отзыв анонимно"
        return label
    }()
    
    //MARK: - Public properties
    
    var viewModel: ProductFeedbackTableModel.DataModel.SendReviewCell.CheckBoxView? {
        didSet {
            updateData()
        }
    }
    
    //MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extension

private extension CheckBoxView {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(checkBoxImageView)
        addSubview(additionalTextLabel)
    }
    
    func setupConstraints() {
        checkBoxImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(14)
        }
        
        additionalTextLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(checkBoxImageView.snp.right).offset(10)
            make.trailing.greaterThanOrEqualToSuperview().inset(14)
        }
        
        checkBoxImageView.snp.contentHuggingHorizontalPriority = 251
        additionalTextLabel.snp.contentHuggingHorizontalPriority = 250
    }
    
    //MARK: - Update data function
    
    func updateData() {
        additionalTextLabel.text = viewModel?.title
    }
}
