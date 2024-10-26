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
    
    private var popUpLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        label.alpha = 0.6
        label.textColor = .white
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        return label
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
        addSubview(popUpLabel)
    }
    
    func setupConstraints() {
        contentTableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        popUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(40)
            make.width.equalTo(183)
        }
    }
}

//MARK: - Extension
extension OrderInfoView {
    
    func setupTable(_ data: [OrderInfoTableViewModel]) {
        contentTableView.setupData(data)
        contentTableView.reloadData()
    }
    
    func insertRows(at indexes: [IndexPath], data: [OrderInfoTableViewModel]) {
        contentTableView.setupData(data)
        contentTableView.insertRows(at: indexes, with: .automatic)
    }
    
    func deleteRows(at indexes: [IndexPath], data: [OrderInfoTableViewModel]) {
        contentTableView.setupData(data)
        contentTableView.deleteRows(at: indexes, with: .automatic)
    }
    
    func reloadCell(at indexes: [IndexPath], data: [OrderInfoTableViewModel]) {
        contentTableView.setupData(data)
        contentTableView.reloadRows(at: indexes, with: .automatic)
    }
    
    func activateSnackBar(_ text: String) {
        popUpLabel.text = text
        popUpLabel.isHidden = false
        UIView.animate(withDuration: 3) { [weak self] in
            self?.popUpLabel.alpha = 0
        }
    }
    
    func deactivateSnackBar() {
        popUpLabel.isHidden = true
        self.popUpLabel.alpha = 0.6
    }
}
