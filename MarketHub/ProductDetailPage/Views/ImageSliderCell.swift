//
//  ImageSliderCell.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 12.01.2024.
//

import UIKit

final class ImageSliderCell: ReusableTableViewCell {
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isPagingEnabled = true
    scrollView.delegate = self
    scrollView.clipsToBounds = true
    scrollView.showsHorizontalScrollIndicator = false
    return scrollView
  }()

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 0
    return stackView
  }()

  private let pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.currentPageIndicatorTintColor = Color.titleColor
    pageControl.pageIndicatorTintColor = .gray
    return pageControl
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
    guard let viewModel = viewModel as? ImageSliderViewModel else { return }
    for imageViewModel in viewModel.imageViewModels {
      createProductImage(with: imageViewModel)
    }
    updateSliderImplementation(with: viewModel.imageViewModels.count)
  }
    
  private func updateSliderImplementation(with count: Int) {
    pageControl.numberOfPages = count
    scrollView.contentSize = CGSize(
      width: contentView.frame.width * CGFloat(count),
      height: scrollView.frame.height
    )
    stackView.widthAnchor.constraint(
      equalTo: scrollView.widthAnchor,
      multiplier: CGFloat(count)
    ).isActive = true
  }
    
  private func createProductImage(with model: ProductImageViewModel) {
    let productImageView = ProductImageView()
    productImageView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(productImageView)
    productImageView.update(with: model)
    productImageView.heightAnchor.constraint(
      equalTo: productImageView.widthAnchor,
      multiplier: 1.2
    ).isActive = true
  }
    
  private func setupViews() {
    contentView.addSubview(scrollView)
    scrollView.addSubview(stackView)
    contentView.addSubview(pageControl)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
      pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
    
  private func setupAccessibilityIdentifiers() {
    contentView.accessibilityIdentifier = AccessibilityIdentifiers.imageSliderCell
  }
}

//MARK: Scroll view delegate
extension ImageSliderCell: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageIndex = round(scrollView.contentOffset.x / contentView.frame.width)
    pageControl.currentPage = Int(pageIndex)
  }
}
