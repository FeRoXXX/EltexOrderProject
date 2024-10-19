//
//  PromoCodeTableViewCell.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 16.10.2024.
//

import UIKit
import SnapKit

final class PromoCodeTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private var mainContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)
        return view
    }()
    
    private var circleViewLeft: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    private var circleViewRight: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var promoCodeTitleHorizontalStack: ThreeItemStack = ThreeItemStack()
    
    private lazy var promoCodeTitleAndDateVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [promoCodeTitleHorizontalStack, promoCodeDateLabel])
        stack.spacing = 10
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var promoCodeTopItemHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [promoCodeTitleAndDateVerticalStack, promoCodeActiveSwitch])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var promoCodeVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [promoCodeTopItemHorizontalStack, promoCodeDescriptionLabel])
        stack.spacing = 8
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    
    private var promoCodeDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)
        return label
    }()
    
    private var promoCodeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)
        return label
    }()
    
    private lazy var promoCodeActiveSwitch: UISwitch = {
        let promoCodeSwitch = UISwitch()
        promoCodeSwitch.onTintColor = .red
        promoCodeSwitch.addTarget(self, action: #selector(togglePromocode), for: .touchUpInside)
        return promoCodeSwitch
    }()
    
    private var cellId: UUID?
    private var toggle: ((Bool, UUID) -> Void)?
    
    var viewModel: OrderInfoTableViewModel.ViewModelType.PromoCell? {
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
private extension PromoCodeTableViewCell {
    
    //MARK: - UI initialization functions
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(mainContentView)
        contentView.addSubview(promoCodeDateLabel)
        contentView.addSubview(promoCodeDescriptionLabel)
        contentView.addSubview(promoCodeActiveSwitch)
        contentView.addSubview(promoCodeTitleHorizontalStack)
        contentView.addSubview(promoCodeTitleAndDateVerticalStack)
        contentView.addSubview(promoCodeTopItemHorizontalStack)
        contentView.addSubview(promoCodeVerticalStack)
        contentView.addSubview(circleViewLeft)
        contentView.addSubview(circleViewRight)
    }
    
    func setupConstraints() {
        mainContentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        promoCodeTitleHorizontalStack.snp.makeConstraints { make in
            make.right.equalTo(promoCodeTitleAndDateVerticalStack)
        }
        
        promoCodeVerticalStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(mainContentView).inset(12)
            make.left.right.equalTo(mainContentView).inset(20)
        }
        
        circleViewLeft.snp.makeConstraints { make in
            make.centerX.equalTo(mainContentView.snp.left)
            make.centerY.equalTo(mainContentView.snp.centerY)
            make.height.width.equalTo(16)
        }
        
        circleViewRight.snp.makeConstraints { make in
            make.centerX.equalTo(mainContentView.snp.right)
            make.centerY.equalTo(mainContentView.snp.centerY)
            make.height.width.equalTo(16)
        }
    }
    
    //MARK: - Setup data function
    func updateUI() {
        guard let data = viewModel else { return }
        
        promoCodeTitleHorizontalStack.setElements((data.title, data.percent))
        promoCodeDateLabel.text = data.date
        promoCodeDescriptionLabel.text = data.additionalInformation
        promoCodeActiveSwitch.isOn = data.isToggle
        cellId = data.id
        toggle = data.toggle
    }
    
    @objc
    func togglePromocode() {
        guard let cellId else { return }
        toggle?(promoCodeActiveSwitch.isOn, cellId)
    }
}

//MARK: - Extension
extension PromoCodeTableViewCell {
    
    //MARK: - Static properties
    static var identifier: String {
        return String(describing: PromoCodeTableViewCell.self)
    }
}
