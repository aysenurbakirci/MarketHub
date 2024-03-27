//
//  ProductnformationCell.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 12.01.2024.
//

import UIKit

final class ProductInformationCell: ReusableTableViewCell {
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = Font.title
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = Font.description
    label.textColor = Color.descriptionColor
    label.numberOfLines = 3
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .equalSpacing
    stackView.axis = .vertical
    stackView.spacing = Spacing.medium
    stackView.backgroundColor = Color.containerBackground
    return stackView
  }()
    
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    setupConstraints()
    setupAccessibilityIdentifiers()
  }
    
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
    setupAccessibilityIdentifiers()
  }
    
  func update(with viewModel: Any?) {
    guard let viewModel = viewModel as? ProductInformationViewModel else {
      return
    }
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.description
  }
    
  private func setupViews() {
    contentView.addSubview(containerStackView)
    containerStackView.addArrangedSubviews(titleLabel, descriptionLabel)
  }
    
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.large),
      containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.large),
      containerStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Spacing.large),
      containerStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Spacing.large)
    ])
  }
    
  private func setupAccessibilityIdentifiers() {
    titleLabel.accessibilityIdentifier = AccessibilityIdentifiers.productDetailTitle
    descriptionLabel.accessibilityIdentifier = AccessibilityIdentifiers.productDetailDescription
    contentView.accessibilityIdentifier = AccessibilityIdentifiers.productInformationCell
  }
}
