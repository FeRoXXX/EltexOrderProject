//
//  InputProductsViewController.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 19.10.2024.
//

import UIKit
import SnapKit

final class InputProductsViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var payProducts: UIButton = {
        var button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Оплатить товары"
        button.configuration = configuration
        button.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        return button
    }()
    private let order = Order(
        screenTitle: "Оформление заказа",
        promocodes: [
            .init(title: "HELLO", percent: 5, endDate: Date(), info: "Промокод действует на первый заказ в приложении", active: false),
            .init(title: "VESNA23", percent: 5, endDate: Date(), info: "Промокод действует для заказов от 30 000 ₽", active: false),
            .init(title: "4300162112534", percent: 5, endDate: Date(), info: nil, active: false),
            .init(title: "4300162112534", percent: 5, endDate: Date(), info: nil, active: true),
            .init(title: "4300162112534", percent: 5, endDate: Date(), info: nil, active: false)
        ],
        products: [.init(price: 10000, title: ""), .init(price: 15000, title: "")],
        paymentDiscount: 5000,
        baseDiscount: 5000)
    
    //MARK: - View did load function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Button target function
    @objc
    func openCart() {
        checkData()
        navigationController?.pushViewController(OrderInfoModuleAssembly.built(order: order), animated: true)
    }
}

//MARK: - Private extension
private extension InputProductsViewController {
    
    //MARK: - UI initialization function
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(payProducts)
    }
    
    func setupConstraints() {
        payProducts.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    //MARK: - Show alert function
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ок", style: .cancel)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    //MARK: - Check data function
    func checkData() {
        if order.products.isEmpty {
            showAlert(message: "Нет продуктов в заказе")
            return
        }
        
        order.products.forEach {
            if $0.price <= 0 {
                showAlert(message: "Стоимость продукта должна быть > 0")
            }
        }
        
        var totalPrice: Double = 0
        
        order.products.forEach { totalPrice += $0.price }
        var currentDiscount = (order.baseDiscount ?? 0) + (order.paymentDiscount ?? 0)
        if  currentDiscount > totalPrice {
            showAlert(message: "Сумма скидки должна быть меньше цены товаров")
            return
        }
        
        order.promocodes.forEach {
            if $0.active {
                currentDiscount += totalPrice * Double($0.percent) / 100
            }
        }
        
        if currentDiscount > totalPrice {
            showAlert(message: "Сумма скидок с учетом 2х промокодов не должна быть больше цены товаров")
            return
        }
    }
}
