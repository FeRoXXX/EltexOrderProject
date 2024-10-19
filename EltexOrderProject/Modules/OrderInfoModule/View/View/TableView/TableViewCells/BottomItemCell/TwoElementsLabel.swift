//
//  TwoElementsLabel.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 17.10.2024.
//

import UIKit
import SnapKit

final class TwoElementsLabel: UIView {
    
    //MARK: - Properties
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftText, info, rightText])
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private var leftText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private var rightText: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private var info: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        var configuration = UIButton.Configuration.plain()
        configuration.image = .info
        button.configuration = configuration
        button.isHidden = true
        return button
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extension
private extension TwoElementsLabel {
    
    //MARK: - UI initialization functions
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(leftText)
        addSubview(rightText)
        addSubview(info)
        addSubview(horizontalStack)
    }
    
    func setupConstraints() {
        horizontalStack.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        leftText.snp.contentHuggingHorizontalPriority = 751
        info.snp.contentHuggingHorizontalPriority = 750
        rightText.snp.contentHuggingHorizontalPriority = 740
    }
}

//MARK: - extension
extension TwoElementsLabel {
    
    //MARK: - Left text functions
    func setLeftTextColor(_ color: UIColor) {
        leftText.textColor = color
    }
    
    func setLeftFont(_ font: UIFont) {
        leftText.font = font
    }
    
    func setLeftText(_ text: String) {
        leftText.text = text
    }
    
    //MARK: - Right text functions
    func setRightTextColor(_ color: UIColor) {
        rightText.textColor = color
    }
    
    func setRightFont(_ font: UIFont) {
        rightText.font = font
    }
    
    func setRightText(_ text: String) {
        rightText.text = text
    }
    
    //MARK: - Info button functions
    func buttonIsHidden(_ bool: Bool) {
        info.isHidden = bool
    }
    
    //MARK: - General text function
    func setText(_ firstText: String, _ secondText: String) {
        leftText.text = firstText
        rightText.text = secondText
    }
    
    func setFont(_ font: UIFont) {
        rightText.font = font
        leftText.font = font
    }
}
