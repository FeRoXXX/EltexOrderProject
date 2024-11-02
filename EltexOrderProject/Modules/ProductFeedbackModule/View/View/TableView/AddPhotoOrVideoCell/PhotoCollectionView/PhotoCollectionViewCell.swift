//
//  PhotoCollectionViewCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 01.11.2024.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Private properties
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = .cross
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        button.configuration = configuration
        button.isHidden = true
        button.addTarget(self, action: #selector(crossIsTapped), for: .touchUpInside)
        return button
    }()
    
    private let uploadImageView: UIImageView = {
        let image = UIImageView()
        image.image = .upload
        image.contentMode = .center
        return image
    }()
    
    //MARK: - Public properties
    
    var viewModel: ProductFeedbackTableModel.DataModel.AddPhotoOrVideoCell.PhotoCell? {
        didSet {
            updateData()
        }
    }
    
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

private extension PhotoCollectionViewCell {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(uploadImageView)
        contentView.addSubview(deleteButton)
    }
    
    func setupConstraints() {
        
        uploadImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(9)
        }
    }
    
    //MARK: - Update data function
    
    func updateData() {
        if let viewModel,
           let image = viewModel.image {
            deleteButton.isHidden = false
            uploadImageView.image = UIImage(named: image)
            uploadImageView.contentMode = .scaleAspectFill
            deleteGesture()
        } else {
            deleteButton.isHidden = true
            uploadImageView.image = .upload
            uploadImageView.contentMode = .center
            setupGesture()
        }
    }
    
    //MARK: - Setup gesture recognizer function
    
    func setupGesture() {
        let gestureView = UITapGestureRecognizer(target: self, action: #selector(cellIsTapped))
        let gestureUploadImageView = UITapGestureRecognizer(target: self, action: #selector(cellIsTapped))
        addGestureRecognizer(gestureView)
        uploadImageView.addGestureRecognizer(gestureUploadImageView)
    }
    
    //MARK: - Delete gesture recognizers
    
    func deleteGesture() {
        if let recognizers = uploadImageView.gestureRecognizers {
            recognizers.forEach {
                uploadImageView.removeGestureRecognizer($0)
            }
        }
        
        if let recognizers = self.gestureRecognizers {
            recognizers.forEach {
                self.removeGestureRecognizer($0)
            }
        }
    }
    
    //MARK: - Gesture recognizer and button functions
    
    @objc
    func cellIsTapped() {
        viewModel?.cellIsTapped?()
    }
    
    @objc
    func crossIsTapped() {
        viewModel?.deleteButtonTapped?(viewModel?.id ?? UUID())
    }
}

//MARK: - Public extension

extension PhotoCollectionViewCell {
    
    //MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
}

