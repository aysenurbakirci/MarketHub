//
//  ViewController.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import UIKit

// MARK: Sections of product list
enum ListingSection: Int, CaseIterable {
  case sponsoredProduct
  case product
}

// MARK: View protocol
protocol ProductListViewing: AnyObject {
  func update(with viewModels: ProductListViewModels)
  func updatePaginationStatus(as isEnabled: Bool)
  func finishPaginationLoading()
  func showLoadingView()
  func hideLoadingView()
}

final class ProductListViewController: UIViewController {
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = Color.pageBackground
    return collectionView
  }()
    
  private lazy var loadingView: LoadingView = {
    let loadingView = LoadingView()
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    return loadingView
  }()
    
  private var viewModels: ProductListViewModels?
  private var isLoading = false
  private var isPaginationEnabled = false
  private var lastContentOffset: CGFloat?
    
  var presenter: ProductListPresenting?

  override func viewDidLoad() {
    super.viewDidLoad()
    configureCompositionalLayout()
    setupCollectionView()
    setupAccessibilityIdentifiers()
    presenter?.viewDidLoad()
  }
    
  private func setupCollectionView() {
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
    registerCells()
  }

  private func registerCells() {
    collectionView.register(
      ProductCell.self,
      forCellWithReuseIdentifier: ProductCell.reuseIdentifier
    )
    collectionView.register(
      SponsoredProductCell.self,
      forCellWithReuseIdentifier: SponsoredProductCell.reuseIdentifier
    )
  }
    
  private func setupAccessibilityIdentifiers() {
    collectionView.accessibilityIdentifier = AccessibilityIdentifiers.listingPage
  }
}

// MARK: ProductListViewing protocol implementing
extension ProductListViewController: ProductListViewing {
  func update(with viewModels: ProductListViewModels) {
    self.viewModels = viewModels
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }

  func updatePaginationStatus(as isEnabled: Bool) {
    isPaginationEnabled = isEnabled
  }

  func finishPaginationLoading() {
    isLoading = false
  }

  func showLoadingView() {
    view.addSubview(loadingView)
    NSLayoutConstraint.activate([
      loadingView.topAnchor.constraint(equalTo: view.topAnchor),
      loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  func hideLoadingView() {
    loadingView.removeFromSuperview()
  }
}

// MARK: Infinity Scroll
extension ProductListViewController {
  private func onInfiniteScrollReachedEnd() {
    guard !isLoading, isPaginationEnabled else { return }
    isLoading = true
    presenter?.onInfiniteScrollReachedEnd()
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let scrollViewContentHeight = collectionView.contentSize.height
    let scrollViewContentOffset = collectionView.contentOffset.y
    let scrollViewOriginalHeight = collectionView.bounds.size.height
    let scrollOffsetThreshold = scrollViewContentHeight - scrollViewOriginalHeight

    if scrollViewContentHeight > scrollViewOriginalHeight,
      scrollViewContentOffset > scrollOffsetThreshold,
      scrollViewContentOffset > lastContentOffset ?? 0 {
      onInfiniteScrollReachedEnd()
    }
    lastContentOffset = scrollViewContentOffset
  }
}

// MARK: Collection View Delegate
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    presenter?.openDetailPage(
      section: ListingSection(rawValue: indexPath.section),
      index: indexPath.row
    )
  }
}

// MARK: Collection View DataSource
extension ProductListViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    guard let section = ListingSection(rawValue: section) else { return 0 }
    switch section {
    case .sponsoredProduct:
      return viewModels?.sponsoredProductCells.count ?? 0
    case .product:
      return viewModels?.productCells.count ?? 0
    }
  }
    
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    ListingSection.allCases.count
  }
    
  func collectionView(
    _ collectionView: UICollectionView, 
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let section = ListingSection(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    switch section {
    case .sponsoredProduct :
      guard let model = viewModels?.sponsoredProductCells[safe: indexPath.row],
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: model.cell.reuseIdentifier,
            for: indexPath) as? ReusableCollectionViewCell
        else { return UICollectionViewCell() }
      cell.update(with: model)
      return cell
    case .product :
      guard let model = viewModels?.productCells[safe: indexPath.row],
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: model.cell.reuseIdentifier,
            for: indexPath) as? ReusableCollectionViewCell
        else { return UICollectionViewCell() }
      cell.update(with: model)
      return cell
    }
  }
}


// MARK: Configure compositional layout
extension ProductListViewController {
  func configureCompositionalLayout(){
    let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
      guard let section = ListingSection(rawValue: sectionIndex), let self = self else {
        return self?.createProductSection()
      }
      switch section {
      case .sponsoredProduct:
        return self.createSponsoredProductSection()
      case .product:
        return self.createProductSection()
      }
    }
    collectionView.setCollectionViewLayout(layout, animated: true)
  }

  func createSponsoredProductSection()-> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = .init(
        top: .zero,
        leading: Spacing.small,
        bottom: Spacing.small,
        trailing: Spacing.small
      )
        
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(0.25)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )

    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPagingCentered
    return section
  }
    
  func createProductSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.5),
        heightDimension: .fractionalHeight(1.0)
      )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(0.4)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.interItemSpacing = .flexible(Spacing.xxSmall)
      
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = Spacing.xxSmall
    section.contentInsets = NSDirectionalEdgeInsets(
        top: Spacing.xSmall,
        leading: Spacing.small,
        bottom: Spacing.xSmall,
        trailing: Spacing.small
    )
    return section
  }
}
