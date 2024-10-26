//
//  ActivatePromocodeViewController.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 25.10.2024.
//

import UIKit

final class ActivatePromocodeViewController: UIViewController {
    
    //MARK: - Properties
    private var contentView: ActivatePromocodeView = ActivatePromocodeView()
    private var viewModel: ActivePromocodeViewModel
    
    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Initialization
    init(viewModel: ActivePromocodeViewModel) {
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
private extension ActivatePromocodeViewController {
    
    //MARK: - UI initialization functions
    func setupUI() {
        self.view = contentView
        setupBackButton()
    }
    
    //MARK: - Setup navigation bar
    func setupBackButton() {
        self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
    }
}

//MARK: - View model delegate
extension ActivatePromocodeViewController: ActivePromocodeViewModelDelegate {
    func clearTextField() {
        contentView.clearTextField()
    }
    
    func makeAlert(_ text: String) {
        contentView.makeAlert(text)
    }
    
    func hideAlert() {
        contentView.hideAlert()
    }
    
    func setData(_ data: ActivePromocodeModel) {
        contentView.setupData(data)
    }
    
    func setupTitle(_ title: String) {
        self.title = title
    }
    
    func closeWindow() {
        navigationController?.popViewController(animated: true)
    }
}
