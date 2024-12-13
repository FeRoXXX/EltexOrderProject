//
//  MainNavigationView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 13.12.2024.
//

import UIKit
import SnapKit
import Combine

final class MainNavigationView: UIView {
    
    //MARK: - Private properties
    
    private(set) var buttonTappedPublisher: PassthroughSubject<Int, Never> = .init()
    
    private lazy var inputPromocodeButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Ввод промокода"
        configuration.background.cornerRadius = 12
        button.configuration = configuration
        button.tag = 0
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var reviewButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Отзыв"
        configuration.background.cornerRadius = 12
        button.configuration = configuration
        button.tag = 1
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var orderCancelButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Отмена заказа"
        configuration.background.cornerRadius = 12
        button.configuration = configuration
        button.tag = 2
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Оформление зкакза"
        configuration.background.cornerRadius = 12
        button.configuration = configuration
        button.tag = 3
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
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

private extension MainNavigationView {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(inputPromocodeButton)
        addSubview(reviewButton)
        addSubview(orderCancelButton)
        addSubview(orderButton)
    }
    
    func setupConstraints() {
        inputPromocodeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(200)
            make.height.equalTo(40)
        }
        
        reviewButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(inputPromocodeButton.snp.bottom).inset(-10)
            make.height.equalTo(40)
        }
        
        orderCancelButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(reviewButton.snp.bottom).inset(-10)
            make.height.equalTo(40)
        }
        
        orderButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(orderCancelButton.snp.bottom).inset(-10)
            make.height.equalTo(40)
        }
    }
    
    //MARK: - Button actions
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        buttonTappedPublisher.send(sender.tag)
    }
}
