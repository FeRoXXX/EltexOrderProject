//
//  ProductStarsCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import UIKit

final class ProductStarsCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private var contentCellView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starsLabel, starsRatingView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private var starsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваша оценка"
        label.font = .systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        return label
    }()
    
    private var starsRatingView: StarsRatingView = {
        let view = StarsRatingView()
        return view
    }()
    
    //MARK: - Public properties
    
    var viewModel: ProductFeedbackTableModel.DataModel.ProductStarsCell? {
        didSet {
            
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

private extension ProductStarsCell {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(contentCellView)
        contentCellView.addSubview(horizontalStack)
    }
    
    func setupConstraints() {
        contentCellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        horizontalStack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    //MARK: - Update data
    
    func updateData() {
        starsLabel.text = viewModel?.title
        starsLabel.textColor = .black
    }
}

//MARK: - Public extension

extension ProductStarsCell {
    
    //MARK: - Static properties
    static var identifier: String {
        return String(describing: self)
    }
}
