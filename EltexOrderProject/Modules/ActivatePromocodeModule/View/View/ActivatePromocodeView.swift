//
//  ActivatePromocodeView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 25.10.2024.
//

import UIKit
import SnapKit

final class ActivatePromocodeView: UIView {
    
    //MARK: - Properties
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [promoCodeTextField, activeButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var activeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        configuration.background.cornerRadius = 12
        configuration.contentInsets = .init(top: 16, leading: 0, bottom: 16, trailing: 0)
        button.configuration = configuration
        button.addTarget(self, action: #selector(activeButtonTarget), for: .touchUpInside)
        return button
    }()
    
    private lazy var promoCodeTextField: PromoCodeTextField = {
        let textField = PromoCodeTextField(delegate: self)
        return textField
    }()
    
    var viewModel: ActivePromocodeModel.ActivePromocodeViewModelType.ActivePromocodeView? {
        didSet {
            updateUI()
        }
    }
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Objc button binding function
    @objc
    func activeButtonTarget() {
        viewModel?.activeButtonClicked?(promoCodeTextField.getTextFieldText())
    }
}

//MARK: - Private extension
private extension ActivatePromocodeView {
    
    //MARK: - UI initialization functions
    func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(promoCodeTextField)
        addSubview(activeButton)
        addSubview(verticalStackView)
    }
    
    func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).inset(16)
        }
    }
}

//MARK: Extension
extension ActivatePromocodeView {
    
    //MARK: - Delegate function
    func clearTextField() {
        promoCodeTextField.clearTextField()
    }
    
    func makeAlert(_ text: String) {
        promoCodeTextField.makeAlert(text)
    }
    
    func hideAlert() {
        promoCodeTextField.hideAlert()
    }
    
    func setupData(_ data: ActivePromocodeModel) {
        switch data.type {
        case .view(let data):
            viewModel = data
        case .textField(let data):
            promoCodeTextField.viewModel = data
        }
    }
    
    func updateUI() {
        activeButton.configuration?.title = viewModel?.buttonText
    }
}

//MARK: - extension + UITextFieldDelegate
extension ActivatePromocodeView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel?.textFieldShouldBeginEditing?()
        return true
    }
}
