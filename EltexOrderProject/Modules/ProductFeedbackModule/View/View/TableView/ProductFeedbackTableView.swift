//
//  ProductFeedbackTableView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 30.10.2024.
//

import UIKit

final class ProductFeedbackTableView: UITableView {
    
    //MARK: - Private properties
    
    private(set) var layoutFlag: Bool = false
    
    //MARK: - Public properties
    
    var data: [ProductFeedbackTableModel] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    var viewModel: ProductFeedbackModel?
    //MARK: - Initialization
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(ProductInfoCell.self, forCellReuseIdentifier: ProductInfoCell.identifier)
        self.register(ProductStarsCell.self, forCellReuseIdentifier: ProductStarsCell.identifier)
        self.register(AddPhotoOrVideoEmptyCell.self, forCellReuseIdentifier: AddPhotoOrVideoEmptyCell.identifier)
        self.register(ReviewTextCell.self, forCellReuseIdentifier: ReviewTextCell.identifier)
        self.register(SendReviewCell.self, forCellReuseIdentifier: SendReviewCell.identifier)
        self.register(StarsErrorCell.self, forCellReuseIdentifier: StarsErrorCell.identifier)
        self.register(AddPhotoOrVideoCell.self, forCellReuseIdentifier: AddPhotoOrVideoCell.identifier)
        self.separatorStyle = .none
        self.delegate = self
        self.dataSource = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if layoutFlag {
            self.beginUpdates()
            self.endUpdates()
            layoutFlag = !layoutFlag
        }
    }
}

//MARK: - Public extension

extension ProductFeedbackTableView {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel?.scrollIsActive?()
    }
}

//MARK: - TableViewProtocols

extension ProductFeedbackTableView: TableViewProtocols {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentData = data[indexPath.row]
        
        switch currentData.type {
        case .productInfoCell(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductInfoCell.identifier, for: indexPath) as? ProductInfoCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .productStarsCell(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductStarsCell.identifier, for: indexPath) as? ProductStarsCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .addPhotoOrVideoEmptyCell(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddPhotoOrVideoEmptyCell.identifier, for: indexPath) as? AddPhotoOrVideoEmptyCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .reviewTextCell(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTextCell.identifier, for: indexPath) as? ReviewTextCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .sendReviewCell(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SendReviewCell.identifier, for: indexPath) as? SendReviewCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .starsErrorCell(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StarsErrorCell.identifier, for: indexPath) as? StarsErrorCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .addPhotoOrVideoCell(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddPhotoOrVideoCell.identifier, for: indexPath) as? AddPhotoOrVideoCell else { return UITableViewCell() }
            cell.viewModel = data
            layoutFlag = true
            cell.selectionStyle = .none
            return cell
        }
    }
}
