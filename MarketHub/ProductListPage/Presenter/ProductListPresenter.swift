//
//  ProductListPresenter.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import Foundation

protocol ProductListPresenting {
  func viewDidLoad()
  func onInfiniteScrollReachedEnd()
  func openDetailPage(section: ListingSection?, index: Int)
}

final class ProductListPresenter {
  private var interactor: ProductListInteracting
  private weak var view: ProductListViewing?
  private var router: ProductListRouting
  private var builder: ProductListViewModelBuilding
  private var nextPageKey: String = "1"
  private var model: ProductListModel?

  init(
    interactor: ProductListInteracting,
    view: ProductListViewing,
    router: ProductListRouting,
    builder: ProductListViewModelBuilding
  ) {
    self.interactor = interactor
    self.view = view
    self.router = router
    self.builder = builder
  }

  private func getProductListData() {
    interactor.fetchProductList(page: nextPageKey) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(viewModel):
        self.model = viewModel
        self.nextPageKey = viewModel.nextPage ?? "1"
        DispatchQueue.main.async {
          self.view?.hideLoadingView()
          self.updateView()
        }
        self.view?.updatePaginationStatus(as: !viewModel.nextPage.isNilOrEmpty)
      case let .failure(error):
        DispatchQueue.main.async {
          self.handleError(errorMessage: error.localizedDescription)
        }
      }
    }
  }

  private func handleError(errorMessage: String) {
    let action = ErrorAction(title: Translations.retryButton.rawValue) { [weak self] _ in
      self?.getProductListData()
    }
    let model = ErrorModel(
      title: Translations.errorTitle.rawValue,
      description: errorMessage,
      action: action
    )
    self.router.showError(with: model)
  }

  private func updateView() {
    let viewModels = builder.buildViewModels(viewModel: model)
    view?.update(with: viewModels)
  }
}

//MARK: ProductListPresenting
extension ProductListPresenter: ProductListPresenting {
  func viewDidLoad() {
    view?.showLoadingView()
    getProductListData()
  }

  func onInfiniteScrollReachedEnd() {
    interactor.fetchProductList(page: nextPageKey) { [weak self] result in
    guard let self = self else { return }
    switch result {
    case let .success(viewModel):
      self.model?.products += viewModel.products
      self.nextPageKey = viewModel.nextPage ?? "1"
      self.updateView()
      self.view?.updatePaginationStatus(as: !viewModel.nextPage.isNilOrEmpty)
    case .failure:
      break
    }
    self.view?.finishPaginationLoading()
    }
  }

  func openDetailPage(section: ListingSection?, index: Int) {
    guard let model = model, let section = section else { return }
    switch section {
    case .sponsoredProduct:
      if let sponsoredProduct = model.sponsoredProducts?[safe: index] {
        router.openDetailPage(with: ProductDetailOpening(productId: sponsoredProduct.id))
      }
    case .product:
      if let product = model.products[safe: index] {
        router.openDetailPage(with: ProductDetailOpening(productId: product.id))
      }
    }
  }
}
