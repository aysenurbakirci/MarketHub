//
//  ProductRatingInformationCell.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import UIKit

final class ProductRatingInformationCell: ReusableTableViewCell {
  private let ratingView: RatingView = {
    let ratingView = RatingView()
    ratingView.translatesAutoresizingMaskIntoConstraints = false
    return ratingView
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
    guard let viewModel = viewModel as? ProductRatingInformationViewModel,
      let ratingModel = viewModel.ratingModel
    else { return }
    ratingView.update(with: ratingModel)
  }
    
  private func setupViews() {
    contentView.addSubview(ratingView)
  }
    
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      ratingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.xSmall),
      ratingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.xSmall),
      ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.large)
    ])
  }
    
  private func setupAccesbilityIdentifiers() {
    contentView.accessibilityIdentifier = AccessibilityIdentifiers.productRatingCell
  }
}
