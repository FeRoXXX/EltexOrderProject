//
//  ProductInfoCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import UIKit
import SnapKit

final class ProductInfoCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private lazy var horizontalMainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productImageView, verticalTextStack])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.layoutMargins = .init(top: 0, left: 16, bottom: 8, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var verticalTextStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)
        return label
    }()
    
    //MARK: - Public properties
    
    var viewModel: DataModel.ProductInfoCell? {
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

private extension ProductInfoCell {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(horizontalMainStack)
    }
    
    func setupConstraints() {
        horizontalMainStack.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints { make in
            make.height.equalTo(productImageView.snp.width)
            make.width.equalTo(80)
        }
    }
    
    //MARK: - Update data function
    
    func updateData() {
        productImageView.image = UIImage(named: viewModel?.imageName ?? "")
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
    }
}

//MARK: - Public extension

extension ProductInfoCell {
    
    //MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
}
