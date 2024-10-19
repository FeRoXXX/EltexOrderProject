//
//  OrderInfoTableView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 18.10.2024.
//

import UIKit

typealias TableProtocols = UITableViewDelegate & UITableViewDataSource

final class OrderInfoTableView: UITableView {
    
    private var data: [OrderInfoTableViewModel] = []
    
    //MARK: - Initialization
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTable()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extension
private extension OrderInfoTableView {
    
    func setupTable() {
        self.delegate = self
        self.dataSource = self
        self.register(PromoCodeTableViewCell.self, forCellReuseIdentifier: PromoCodeTableViewCell.identifier)
        self.register(PromoCodeTopItemCell.self, forCellReuseIdentifier: PromoCodeTopItemCell.identifier)
        self.register(HidePromoCodesCell.self, forCellReuseIdentifier: HidePromoCodesCell.identifier)
        self.register(PromoCodeBottomItemCell.self, forCellReuseIdentifier: PromoCodeBottomItemCell.identifier)
    }
}

//MARK: - Object functions
extension OrderInfoTableView {
    
    //MARK: - Setup data function
    func setupData(_ data: [OrderInfoTableViewModel]) {
        self.data = data
    }
}

//MARK: - TableViewDelegate + TableViewDataSource extension
extension OrderInfoTableView: TableProtocols {
    
    //MARK: - DataSource functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentData = data[indexPath.row]
        
        switch currentData.type {
        case .topItem(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoCodeTopItemCell.identifier, for: indexPath) as? PromoCodeTopItemCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .promo(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoCodeTableViewCell.identifier, for: indexPath) as? PromoCodeTableViewCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .hidePromo(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HidePromoCodesCell.identifier, for: indexPath) as? HidePromoCodesCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .bottomItem(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoCodeBottomItemCell.identifier, for: indexPath) as? PromoCodeBottomItemCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        }
    }
}
