//
//  SponsoredProductCell.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 10.01.2024.
//

import UIKit

final class SponsoredProductCell: ReusableCollectionViewCell {
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
    ratingView.isHidden = true
    return ratingView
  }()

  private let priceView: PriceView = {
    let priceView = PriceView()
    priceView.translatesAutoresizingMaskIntoConstraints = false
    return priceView
  }()
    
  private let sponsoredBanner: ProductBanner = {
    let banner = ProductBanner()
    banner.translatesAutoresizingMaskIntoConstraints = false
    banner.isHidden = true
    return banner
  }()

  private let infoStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = Spacing.small
    stackView.alignment = .leading
    stackView.axis = .vertical
    return stackView
  }()
    
  private let containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .center
    stackView.spacing = Spacing.small
    stackView.axis = .horizontal
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
    setupConstraints()  }
    
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
  }
    
  func update(with viewModel: Any?) {
    guard let viewModel = viewModel as? SponsoredProductCellViewModel else { return }
    titleLabel.text = viewModel.title
    priceView.update(with: viewModel.priceModel)
    imageView.update(with: viewModel.imageModel)
    if let bannerTitle = viewModel.bannerTitle {
      sponsoredBanner.update(with: bannerTitle)
      sponsoredBanner.isHidden = false
    }
    if let ratingModel = viewModel.ratingModel {
      ratingView.update(with: ratingModel)
      ratingView.isHidden = false
    }
    setupAccessibilityIdentifiers(with: "\(viewModel.id)")
  }
    
  private func setupViews() {
    contentView.addSubview(containerView)
    containerView.addSubviews(containerStackView, ratingView, sponsoredBanner)
    containerStackView.addArrangedSubviews(imageView, infoStackView)
    infoStackView.addArrangedSubviews(titleLabel, priceView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      // Image View Constraints
      imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Spacing.large),
      imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Spacing.large),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.6),

      // Info Stack View Constraints
      infoStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Spacing.large),

      // Rating View Constraints
      ratingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Spacing.large),
      ratingView.topAnchor.constraint(greaterThanOrEqualTo: containerStackView.bottomAnchor, constant: Spacing.small),
      ratingView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -Spacing.large),

      // Sponsored Banner Constraints
      sponsoredBanner.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Spacing.large),
      sponsoredBanner.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Spacing.large),

      // Container View Constraints
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }

  private func setupAccessibilityIdentifiers(with id: String) {
    contentView.accessibilityIdentifier = AccessibilityIdentifiers.sponsoredProductCell(id: id)
  }
}

