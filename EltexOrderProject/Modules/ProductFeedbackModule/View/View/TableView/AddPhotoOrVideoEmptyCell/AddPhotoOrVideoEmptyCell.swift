//
//  AddPhotoOrVideoEmptyCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import UIKit
import SnapKit

final class AddPhotoOrVideoEmptyCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private let contentCellView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionImageView, verticalTextStackView])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var verticalTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private let descriptionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .upload
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - Public properties
    
    var viewModel: DataModel.AddPhotoOrVideoEmptyCell? {
        didSet {
            updateData()
        }
    }
    
    var onCellIsTapped: (() -> Void)?
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupGesture()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extension

private extension AddPhotoOrVideoEmptyCell {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(contentCellView)
        contentCellView.addSubview(horizontalStackView)
    }
    
    func setupConstraints() {
        contentCellView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(21)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    //MARK: - Setup gesture recognizer
    
    func setupGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addPhoto))
        addGestureRecognizer(gestureRecognizer)
    }
    
    //MARK: - update data function
    
    func updateData() {
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
    }
    
    //MARK: - Gesture recognizer function
    
    @objc
    func addPhoto() {
        onCellIsTapped?()
    }
}

//MARK: - Public extension

extension AddPhotoOrVideoEmptyCell {
    
    //MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
}
