//
//  OrderInfoView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 16.10.2024.
//

import UIKit
import SnapKit

final class OrderInfoView: UIView {
    
    //MARK: - Properties
    private lazy var contentTableView: OrderInfoTableView = {
        let tableView = OrderInfoTableView()
        tableView.backgroundColor = #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extension
private extension OrderInfoView {
    
    //MARK: - UI initialization functions
    func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(contentTableView)
    }
    
    func setupConstraints() {
        contentTableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: - Extension
extension OrderInfoView {
    
    func setupTable(_ data: [OrderInfoTableViewModel]) {
        contentTableView.setupData(data)
        contentTableView.reloadData()
    }
}
