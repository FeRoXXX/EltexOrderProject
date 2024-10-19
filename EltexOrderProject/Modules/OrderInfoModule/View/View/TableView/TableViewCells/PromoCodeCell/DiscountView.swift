//
//  DiscountView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 17.10.2024.
//

import UIKit
import SnapKit

final class DiscountView: UIView {
    
    //MARK: - Properties
    private var discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    private var contentMainView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.754624784, blue: 0.5331450701, alpha: 1)
        return view
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
    
    //MARK: - Update ui functions
    override func layoutSubviews() {
        super.layoutSubviews()
        contentMainView.layer.cornerRadius = contentMainView.frame.height / 2
    }
}

//MARK: - Private extension
private extension DiscountView {
    
    //MARK: - UI initialization
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(contentMainView)
        contentMainView.addSubview(discountLabel)
    }
    
    func setupConstraints() {
        contentMainView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.trailing.leading.greaterThanOrEqualToSuperview()
        }
        
        discountLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(3)
            make.trailing.leading.equalToSuperview().inset(5)
        }
    }
}

//MARK: - Extension
extension DiscountView {
    
    func setDiscount(_ discount: Int) {
        discountLabel.text = "-\(discount)%"
    }
}
