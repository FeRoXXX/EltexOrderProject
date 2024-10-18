//
//  OrderInfoViewController.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 16.10.2024.
//

import UIKit

final class OrderInfoViewController: UIViewController {
    
    //MARK: - Properties
    private let contentView = OrderInfoView()
    private let viewModel: OrderInfoViewModel
    
    //MARK: - ViewDidLoad function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Initialization functions
    init(viewModel: OrderInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extension
private extension OrderInfoViewController {
    
    //MARK: - UI initialization functions
    func setupUI() {
        self.view = contentView
        setupTitle()
    }
    
    func setupTitle() {
        title = "Оформление заказа"
    }
}

//MARK: - OrderInfoViewModelDelegate
extension OrderInfoViewController: OrderInfoViewModelDelegate {
    
    func cellDidChange(_ data: [OrderInfoTableViewModel]) {
        contentView.setupTable(data)
    }
}
