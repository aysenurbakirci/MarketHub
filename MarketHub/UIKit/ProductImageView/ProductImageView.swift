//
//  ProductImageView.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 12.01.2024.
//

import UIKit

final class ProductImageView: UIView {
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
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
    
  func update(with viewModel: ProductImageViewModel) {
    ImageLoader.shared.loadImage(
      from: viewModel.imageUrlString,
      placeholder: viewModel.placeholderImage,
      completion: { [weak self] image in
        DispatchQueue.main.async {
        self?.imageView.image = image
        }
      }
    )
  }
    
  private func setupViews() {
    addSubview(imageView)
  }
    
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
