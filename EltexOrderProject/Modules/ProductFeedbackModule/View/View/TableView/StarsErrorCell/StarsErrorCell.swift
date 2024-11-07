//
//  StarsErrorCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 01.11.2024.
//

import UIKit
import SnapKit

final class StarsErrorCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private let contentCellView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9416797161, blue: 0.9403678775, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9758322835, green: 0.2742320597, blue: 0.2279928625, alpha: 1)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .warningCircle
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Public properties
    
    var viewModel: StarsErrorCellModel? {
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

private extension StarsErrorCell {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(contentCellView)
        contentCellView.addSubview(errorLabel)
        contentCellView.addSubview(errorImageView)
    }
    
    func setupConstraints() {
        
        contentCellView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(4)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
        }
        
        errorImageView.snp.makeConstraints { make in
            make.left.equalTo(errorLabel.snp.right).offset(16)
            make.top.equalTo(errorLabel.snp.top)
            make.trailing.equalToSuperview().inset(16)
        }
        
        errorLabel.snp.contentHuggingHorizontalPriority = 249
        errorImageView.snp.contentHuggingHorizontalPriority = 251
        
    }
    
    //MARK: - Update data function
    
    func updateData() {
        errorLabel.text = viewModel?.errorLabel
    }
}

//MARK: - Public extension

extension StarsErrorCell {
    
    //MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
}
