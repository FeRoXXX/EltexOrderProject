//
//  ThreeItemStack.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 17.10.2024.
//

import UIKit
import SnapKit

final class ThreeItemStack: UIView {
    
    //MARK: - Properties
    private var leftElement: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)
        return label
    }()
    
    private var middleElement: DiscountView = {
        let view = DiscountView()
        return view
    }()
    
    private var rightElement: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        var configuration = UIButton.Configuration.plain()
        configuration.image = .info
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        button.configuration = configuration
        button.isHidden = false
        return button
    }()
    
    private lazy var itemHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftElement, middleElement, rightElement])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fill
        return stack
    }()
    
    //MARK: - Initialization functions
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
private extension ThreeItemStack {
    
    //MARK: - UI initialization
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(leftElement)
        addSubview(middleElement)
        addSubview(rightElement)
        addSubview(itemHorizontalStack)
    }
    
    func setupConstraints() {
        itemHorizontalStack.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        rightElement.snp.contentCompressionResistanceHorizontalPriority = 752
        middleElement.snp.contentCompressionResistanceHorizontalPriority = 752
    }
}

//MARK: - Extension
extension ThreeItemStack {
    
    func setElements(_ data: (String, Int)) {
        leftElement.text = data.0
        middleElement.setDiscount(data.1)
    }
}
