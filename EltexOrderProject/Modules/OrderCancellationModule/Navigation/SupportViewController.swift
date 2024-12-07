//
//  SupportViewController.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 07.12.2024.
//

import UIKit
import SwiftUI
import SnapKit

final class SupportViewController: UIViewController {
    let swiftUINavigation = NavigationView()
    
    //MARK: - Private properties
    
    private lazy var routeButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Отменить заказ"
        configuration.background.backgroundColor = .orange
        configuration.background.cornerRadius = 12
        button.configuration = configuration
        button.addTarget(self, action: #selector(routButtonAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Private extension

private extension SupportViewController {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(routeButton)
    }
    
    func setupConstraints() {
        routeButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    //MARK: - Routing
    
    func routeToCancellableOrder() {
        let navigationController = UIHostingController(rootView: swiftUINavigation)
        self.navigationController?.pushViewController(navigationController, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - Button actions
    
    @objc func routButtonAction() {
        routeToCancellableOrder()
    }
}
