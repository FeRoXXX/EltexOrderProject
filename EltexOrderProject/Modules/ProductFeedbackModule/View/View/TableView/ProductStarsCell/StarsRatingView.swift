//
//  StarsRatingView.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 31.10.2024.
//

import UIKit
import SnapKit

final class StarsRatingView: UIView {
    
    //MARK: - Private properties
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starFirst, starSecond, starThird, starFourth, starFifth])
        stack.spacing = 8
        return stack
    }()
    
    private let starFirst: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .star
        return imageView
    }()
    
    private let starSecond: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .star
        return imageView
    }()
    
    private let starThird: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .star
        return imageView
    }()
    
    private let starFourth: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .star
        return imageView
    }()
    
    private let starFifth: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .star
        return imageView
    }()
    
    //MARK: - Public properties
    
    var viewModel: ProductStarsCellModel.StarsRatingViewModel? {
        didSet {
            updateData()
        }
    }
    
    var onRatingTapped: ((Double, CGFloat) -> Void)?
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGestureRecognizers()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private extension

private extension StarsRatingView {
    
    //MARK: - UI initialization functions
    
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(horizontalStack)
    }
    
    func setupConstraints() {
        horizontalStack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Gesture recognizer functions
    
    func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMoreActions(touch: )))
        tap.numberOfTapsRequired = 1
        horizontalStack.addGestureRecognizer(tap)
    }
    
    @objc
    func showMoreActions(touch: UITapGestureRecognizer) {
        onRatingTapped?(Double(touch.location(in: touch.view).x), starFirst.frame.width)
    }
    
    //MARK: - Update data function
    
    func updateData() {
        guard let viewModel else { return }
        switch viewModel.currentRating {
        case .first:
            starFirst.image = .starFill
            starSecond.image = .star
            starThird.image = .star
            starFourth.image = .star
            starFifth.image = .star
        case .second:
            starFirst.image = .starFill
            starSecond.image = .starFill
            starThird.image = .star
            starFourth.image = .star
            starFifth.image = .star
        case .third:
            starFirst.image = .starFill
            starSecond.image = .starFill
            starThird.image = .starFill
            starFourth.image = .star
            starFifth.image = .star
        case .fourth:
            starFirst.image = .starFill
            starSecond.image = .starFill
            starThird.image = .starFill
            starFourth.image = .starFill
            starFifth.image = .star
        case .fifth:
            starFirst.image = .starFill
            starSecond.image = .starFill
            starThird.image = .starFill
            starFourth.image = .starFill
            starFifth.image = .starFill
        case .none:
            starFirst.image = .star
            starSecond.image = .star
            starThird.image = .star
            starFourth.image = .star
            starFifth.image = .star
        }
    }
}
