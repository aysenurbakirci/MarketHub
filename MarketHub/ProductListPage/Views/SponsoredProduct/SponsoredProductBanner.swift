//
//  ProductBanner.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 13.01.2024.
//

import UIKit

class ProductBanner: UIView {
  private let label: UILabel = {
    let label = UILabel()
    label.textColor = Color.bannerText
    label.font = Font.description
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    setupAccessibilityIdentifiers()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
    setupConstraints()
    setupAccessibilityIdentifiers()
  }
    
  func update(with text: String) {
    label.text = text
  }

  private func setupViews() {
    backgroundColor = Color.banner
    layer.cornerRadius = CornerRadius.banner
    addSubview(label)
  }
    
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.xxSmall),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.xSmall),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.xSmall),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.xxSmall)
    ])
  }
    
  private func setupAccessibilityIdentifiers() {
    accessibilityIdentifier = AccessibilityIdentifiers.banner
  }
}
