//
//  PromoCodeBottomItemCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 17.10.2024.
//

import UIKit
import SnapKit

final class PromoCodeBottomItemCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceLabel, discountLabel, promoCodeLabel, paymentMethodLabel, separatorView, finalPrice, placeAnOrderButton, userAgreementLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private var priceLabel: TwoElementsLabel = {
        let label = TwoElementsLabel()
        return label
    }()
    
    private var discountLabel: TwoElementsLabel = {
        let label = TwoElementsLabel()
        label.setRightTextColor(#colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1))
        return label
    }()
    
    private var promoCodeLabel: TwoElementsLabel = {
        let label = TwoElementsLabel()
        label.setRightTextColor(#colorLiteral(red: 0, green: 0.754624784, blue: 0.5331450701, alpha: 1))
        label.buttonIsHidden(false)
        return label
    }()
    
    private var paymentMethodLabel: TwoElementsLabel = {
        let label = TwoElementsLabel()
        return label
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9341433644, green: 0.9341433644, blue: 0.9341433644, alpha: 1)
        return view
    }()
    
    private var finalPrice: TwoElementsLabel = {
        let label = TwoElementsLabel()
        return label
    }()
    
    private var placeAnOrderButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        configuration.background.cornerRadius = 12
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        return button
    }()
    
    private var userAgreementLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var viewModel: OrderInfoTableViewModel.ViewModelType.BottomItemCell? {
        didSet {
            updateUI()
        }
    }
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extension
private extension PromoCodeBottomItemCell {
    
    //MARK: - UI initialization
    func setupUI() {
        backgroundColor = #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(priceLabel)
        contentView.addSubview(discountLabel)
        contentView.addSubview(promoCodeLabel)
        contentView.addSubview(paymentMethodLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(finalPrice)
        contentView.addSubview(placeAnOrderButton)
        contentView.addSubview(userAgreementLabel)
        contentView.addSubview(verticalStack)
    }
    
    func setupConstraints() {
        verticalStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        placeAnOrderButton.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
    }
    
    //MARK: - Setup data function
    func updateUI() {
        guard let data = viewModel else { return }
        
        priceLabel.setText(data.generalTitle, data.generalPrice)
        discountLabel.setText(data.discountTitle, data.discountPrice)
        promoCodeLabel.setText(data.promoCodeTitle, data.promoCodePrice)
        paymentMethodLabel.setText(data.paymentMethodTitle, data.paymentMethodPrice)
        finalPrice.setText(data.resultTitle, data.resultPrice)
        finalPrice.setFont(UIFont.systemFont(ofSize: 18))
        placeAnOrderButton.configuration?.title = data.nextButtonTitle
        userAgreementLabel.attributedText = data.userAgreement
    }
}

//MARK: - extension
extension PromoCodeBottomItemCell {
    
    //MARK: - Static properties
    static var identifier: String {
        return String(describing: PromoCodeBottomItemCell.self)
    }
}
