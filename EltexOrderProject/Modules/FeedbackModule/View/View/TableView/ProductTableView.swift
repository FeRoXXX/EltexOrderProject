//
//  ProductTableView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 29.10.2024.
//

import UIKit

typealias TableViewProtocols = UITableViewDataSource & UITableViewDelegate

final class ProductTableView: UITableView {
    
    //MARK: - Public properties
    
    var cellDidSelect: ((Int) -> Void)?
    
    var viewModel: [ProductTableModel] = [] {
        didSet {
            updateUI()
        }
    }
    
    
    //MARK: - Initialization
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
        self.contentInset = .init(top: 4, left: 0, bottom: 4, right: 0)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func updateUI() {
        self.reloadData()
    }
}

//MARK: - TableViewProtocols
extension ProductTableView: TableViewProtocols {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentData = viewModel[indexPath.row]
        let tableViewCell = UITableViewCell()
        var configuration = tableViewCell.defaultContentConfiguration()
        configuration.text = currentData.title
        configuration.image = UIImage(named: currentData.imageName)
        configuration.imageProperties.cornerRadius = 12
        configuration.imageProperties.maximumSize = .init(width: 80, height:  80)
        configuration.imageToTextPadding = 12
        configuration.directionalLayoutMargins = .init(top: 12, leading: 0, bottom: 12, trailing: 40)
        tableViewCell.contentConfiguration = configuration
        tableViewCell.accessoryType = .disclosureIndicator
        tableViewCell.selectionStyle = .none
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellDidSelect?(indexPath.row)
    }
}
