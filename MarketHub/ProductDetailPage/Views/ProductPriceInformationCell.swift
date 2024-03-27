//
//  ProductPriceInformationCell.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import UIKit

final class ProductPriceInformationCell: ReusableTableViewCell {
  private let priceView: PriceView = {
    let priceView = PriceView()
    priceView.translatesAutoresizingMaskIntoConstraints = false
    return priceView
  }()
    
  private lazy var banner: ProductBanner = {
    let banner = ProductBanner()
    banner.translatesAutoresizingMaskIntoConstraints = false
    return banner
  }()
    
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = Spacing.medium
    stackView.alignment = .center
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    setupConstraints()
    setupAccesbilityIdentifiers()
  }
    
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
    setupAccesbilityIdentifiers()
  }

  func update(with viewModel: Any?) {
    guard let viewModel = viewModel as? ProductPriceInformationViewModel else { return }
    priceView.update(with: viewModel.priceModel)
    if let discountPercent = viewModel.discountPercent {
      banner.update(with: discountPercent)
    }
  }
    
  private func setupViews() {
    contentView.addSubview(stackView)
    stackView.addArrangedSubviews(banner, priceView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.xSmall),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.xSmall),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.large)
    ])
  }
    
  private func setupAccesbilityIdentifiers() {
    contentView.accessibilityIdentifier = AccessibilityIdentifiers.productPriceCell
  }
}
