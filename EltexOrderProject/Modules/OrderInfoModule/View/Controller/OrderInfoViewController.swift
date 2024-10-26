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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
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
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = .white
        standard.shadowColor = .black
        navigationController?.navigationBar.standardAppearance = standard
    }
}

//MARK: - OrderInfoViewModelDelegate
extension OrderInfoViewController: OrderInfoViewModelDelegate {
    
    func openActivePromocode(_ data: [Order.Promocode]) {
        navigationController?.pushViewController(ActivePromocodeModuleAssembly.build(data, viewModel), animated: true)
    }
    
    func cellDidChange(_ data: [OrderInfoTableViewModel]) {
        contentView.setupTable(data)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ок", style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func deleteRows(at indexes: [IndexPath], data: [OrderInfoTableViewModel]) {
        contentView.deleteRows(at: indexes, data: data)
    }
    
    func insertRows(at indexes: [IndexPath], data: [OrderInfoTableViewModel]) {
        contentView.insertRows(at: indexes, data: data)
    }
    
    func reloadCell(at indexes: [IndexPath], data: [OrderInfoTableViewModel]) {
        contentView.reloadCell(at: indexes, data: data)
    }
    
    func activateSnackBar(_ text: String) {
        contentView.activateSnackBar(text)
    }
    
    func deactivateSnackBar() {
        contentView.deactivateSnackBar()
    }
}
