//
//  PhotoCollectionView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 01.11.2024.
//

import UIKit
import SnapKit

typealias CollectionViewProtocols = UICollectionViewDelegate & UICollectionViewDataSource

final class PhotoCollectionView: UICollectionView {
    
    //MARK: - Public properties
    
    var viewModel: DataModel.AddPhotoOrVideoCell? {
        didSet {
            self.reloadData()
        }
    }
    
    var onAddButtonTapped: (() -> Void)?
    var onDeleteButtonTapped: ((UUID) -> Void)?
    
    //MARK: - Initialization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        self.dataSource = self
        self.isScrollEnabled = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Collection view protocols

extension PhotoCollectionView: CollectionViewProtocols {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.cell.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentElement = viewModel?.cell[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = currentElement
        cell.onAddButtonTapped = { [weak self] in
            self?.onAddButtonTapped?()
        }
        
        cell.onDeleteButtonTapped = { [weak self] id in
            self?.onDeleteButtonTapped?(id)
        }
        return cell
    }
}
