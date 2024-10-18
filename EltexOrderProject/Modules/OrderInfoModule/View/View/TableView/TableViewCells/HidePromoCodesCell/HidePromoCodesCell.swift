//
//  HidePromoCodesCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 17.10.2024.
//

import UIKit
import SnapKit

final class HidePromoCodesCell: UITableViewCell {
    
    //MARK: - Properties
    private var hideButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        button.configuration = configuration
        return button
    }()
    
    var viewModel: OrderInfoTableViewModel.ViewModelType.HidePromoCell? {
        didSet {
            updateUI()
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
private extension HidePromoCodesCell {
    
    //MARK: - UI initialization functions
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(hideButton)
    }
    
    func setupConstraints() {
        hideButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(32)
            make.top.equalToSuperview().inset(9)
            make.bottom.equalToSuperview().inset(33)
        }
    }
    
    //MARK: - Setup data function
    func updateUI() {
        guard let data = viewModel else { return }
        
        hideButton.configuration?.title = data.title
    }
}

//MARK: - Extension
extension HidePromoCodesCell {
    
    //MARK: - Static properties
    static var identifier: String {
        return String(describing: HidePromoCodesCell.self)
    }
}
