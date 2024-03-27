//
//  LoadingView.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 13.01.2024.
//

import UIKit

final class LoadingView: UIView {
  private let activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.color = .gray
    indicator.startAnimating()
    return indicator
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

  private func setupViews() {
    addSubview(activityIndicator)
  }
    
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
