//
//  SendReviewCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import UIKit
import SnapKit

final class SendReviewCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private let checkBoxView: CheckBoxView = {
        let checkBoxView = CheckBoxView()
        return checkBoxView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        configuration.background.cornerRadius = 12
        button.configuration = configuration
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let userAgreementLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Public properties
    
    var viewModel: ProductFeedbackTableModel.DataModel.SendReviewCell? {
        didSet {
            updateData()
        }
    }
    
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

private extension SendReviewCell {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(checkBoxView)
        contentView.addSubview(sendButton)
        contentView.addSubview(userAgreementLabel)
    }
    
    func setupConstraints() {
        
        checkBoxView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(28)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(checkBoxView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
        
        userAgreementLabel.snp.makeConstraints { make in
            make.top.equalTo(sendButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
    }
    
    //MARK: - Update ui functions
    
    func updateData() {
        checkBoxView.viewModel = viewModel?.checkBox
        sendButton.configuration?.title = viewModel?.buttonTitle
        guard let viewModel else { return }
        userAgreementLabel.attributedText = styledText(from: viewModel.userAgreement, highlightedText: viewModel.userAgreementHighlighted)
    }
    
    //MARK: - Button trigger function
    
    @objc
    func sendButtonTapped() {
        viewModel?.sendButtonIsTapped?()
    }
    
    //MARK: - Style user agreement text
    
    func styledText(from text: String, highlightedText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1), range: .init(location: 0, length: attributedString.length))
        
        if let range = text.range(of: highlightedText) {
            let nsRange = NSRange(range, in: text)
            
            attributedString.addAttribute(.foregroundColor, value: #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1), range: nsRange)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
        }
        
        return attributedString
    }
}

//MARK: - Public extension

extension SendReviewCell {
    
    //MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
}
