//
//  ProductCell.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 10.01.2024.
//

import UIKit

final class ProductCell: ReusableCollectionViewCell {
  private lazy var imageView: ProductImageView = {
    let imageView = ProductImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
    
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = Font.title
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
  private let ratingView: RatingView = {
    let ratingView = RatingView()
    ratingView.translatesAutoresizingMaskIntoConstraints = false
    return ratingView
  }()

  private let priceView: PriceView = {
    let priceView = PriceView()
    priceView.translatesAutoresizingMaskIntoConstraints = false
    return priceView
  }()
    
  private let sellerLabel: UILabel = {
    let label = UILabel()
    label.font = Font.smallDescription
    label.textColor = Color.descriptionColor
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
  private let containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .equalSpacing
    stackView.axis = .vertical
    return stackView
  }()
    
  private let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = Color.containerBackground
    view.clipsToBounds = true
    view.layer.cornerRadius = CornerRadius.container
    return view
  }()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
    
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
  }
    
  func update(with viewModel: Any?) {
    guard let viewModel = viewModel as? ProductCellViewModel else { return }
    titleLabel.text = viewModel.title
    sellerLabel.text = viewModel.sellerName
    priceView.update(with: viewModel.priceModel)
    imageView.update(with: viewModel.imageModel)
    if let ratingModel = viewModel.ratingModel {
      ratingView.update(with: ratingModel)
    }
    setupAccessibilityIdentifiers(with: viewModel.id)
  }
    
  private func setupViews() {
    contentView.addSubview(containerView)
    containerView.addSubview(containerStackView)
    containerStackView.addArrangedSubviews(imageView, titleLabel, ratingView, priceView, sellerLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      // Container Stack View Constraints
      containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Spacing.small),
      containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Spacing.small),
      containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Spacing.small),
      containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Spacing.small),
        
      // Container View Constraints
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      // Image View Constraints
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.2),
    ])
  }

  private func setupAccessibilityIdentifiers(with id: Int) {
    imageView.accessibilityIdentifier = AccessibilityIdentifiers.productCell(id: "\(id)")
  }
}
