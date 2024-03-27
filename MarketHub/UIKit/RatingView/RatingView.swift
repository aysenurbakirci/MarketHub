//
//  RatingView.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 10.01.2024.
//

import UIKit

final class RatingView: UIView {
  enum Constants {
    static let iconSize = 12.0
  }

  private let ratingLabel: UILabel = {
    let label = UILabel()
    label.font = Font.rating
    label.textColor = Color.descriptionColor
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let ratingStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.spacing = 2
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
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
    
  func update(with viewModel: RatingViewModel) {
    ratingStackView.removeAllArrangedSubviews()
    ratingLabel.text = "\(viewModel.rating)"
      for (index, starType) in viewModel.starTypes.enumerated() {
      switch starType {
      case .empty:
        let accessibility = AccessibilityIdentifiers.ratingStarView(
          index: "\(index)",
          type: String(describing: starType)
        )
      addImage(image: .emptyStar, index: index, accessibility: accessibility)
      case .filled:
        let accessibility = AccessibilityIdentifiers.ratingStarView(
          index: "\(index)",
          type: String(describing: starType)
        )
      addImage(image: .filledStar, index: index, accessibility: accessibility)
      case .half:
        let accessibility = AccessibilityIdentifiers.ratingStarView(
          index: "\(index)",
          type: String(describing: starType)
        )
      addImage(image: .halfStar, index: index, accessibility: accessibility)
      }
    }
    ratingStackView.addArrangedSubview(ratingLabel)
  }
    
  private func setupViews() {
    addSubview(containerView)
    containerView.addSubviews(ratingStackView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      containerView.leftAnchor.constraint(equalTo: leftAnchor),
      containerView.rightAnchor.constraint(equalTo: rightAnchor),
      ratingStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
      ratingStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      ratingStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
    ])
  }
    
  private func addImage(image: AssetIdentifier, index: Int, accessibility: String) {
    let image = UIImage(image: image)?.withRenderingMode(.alwaysTemplate)
    let imageView = UIImageView(image: image)
    imageView.tintColor = Color.ratingColor
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.widthAnchor.constraint(equalToConstant: Constants.iconSize).isActive = true
    imageView.heightAnchor .constraint(equalToConstant: Constants.iconSize).isActive = true
    ratingStackView.addArrangedSubview(imageView)
    imageView.accessibilityIdentifier = accessibility
  }
    
  private func setupAccessibilityIdentifiers() {
    ratingLabel.accessibilityIdentifier = AccessibilityIdentifiers.averageRatingText
  }
}
