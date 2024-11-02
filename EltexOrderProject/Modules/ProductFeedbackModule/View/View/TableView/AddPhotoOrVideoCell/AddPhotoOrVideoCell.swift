//
//  AddPhotoOrVideoCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 01.11.2024.
//

import UIKit
import SnapKit

final class AddPhotoOrVideoCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private lazy var photoCollectionView: PhotoCollectionView = {
        let collectionView = PhotoCollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        return collectionView
    }()
    
    func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 4
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / 4.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0 / 4.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    //MARK: - Public properties
    
    var viewModel: ProductFeedbackTableModel.DataModel.AddPhotoOrVideoCell? {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size = CGSize(width: self.frame.size.width, height: photoCollectionView.collectionViewLayout.collectionViewContentSize.height)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return photoCollectionView.collectionViewLayout.collectionViewContentSize
    }
}

//MARK: - Private extension

private extension AddPhotoOrVideoCell {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(photoCollectionView)
    }
    
    func setupConstraints() {
        photoCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Setup data function
    
    func updateData() {
        photoCollectionView.viewModel = viewModel
    }
}

//MARK: - Public extension

extension AddPhotoOrVideoCell {
    
    //MARK: - Static properties
    
    static var identifier: String {
        return String(describing: self)
    }
}
