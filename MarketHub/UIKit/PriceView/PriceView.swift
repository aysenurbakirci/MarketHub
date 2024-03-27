//
//  DiscountPriceView.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 10.01.2024.
//

import UIKit

final class PriceView: UIView {
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.font = Font.priceLigth
    label.textColor = Color.descriptionColor
    label.isHidden = false
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
  private let discountPriceLabel: UILabel = {
    let label = UILabel()
    label.font = Font.price
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let priceStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .equalCentering
    stackView.axis = .vertical
    return stackView
  }()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
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
    
  func update(with viewModel: PriceViewModel) {
    if let oldPrice = viewModel.price {
      priceLabel.attributedText = strikethroughText(oldPrice)
      priceLabel.isHidden = false
    }
    discountPriceLabel.text = viewModel.salePrice
  }
    
  private func setupViews() {
    addSubview(priceStackView)
    priceStackView.addArrangedSubviews(priceLabel, discountPriceLabel)
  }
    
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      priceStackView.topAnchor.constraint(equalTo: topAnchor),
      priceStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      priceStackView.leftAnchor.constraint(equalTo: leftAnchor),
      priceStackView.rightAnchor.constraint(equalTo: rightAnchor)
    ])
  }
    
  private func strikethroughText(_ text: String) -> NSAttributedString {
    let attributes: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue
    ]
    let attributedString = NSAttributedString(string: text, attributes: attributes)
    return attributedString
  }
    
  private func setupAccessibilityIdentifiers() {
    priceLabel.accessibilityIdentifier = AccessibilityIdentifiers.priceText
    discountPriceLabel.accessibilityIdentifier = AccessibilityIdentifiers.discountPriceText
  }
}
