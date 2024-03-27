//
//  ProductDetailPresenter.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import Foundation

protocol ProductDetailPresenting {
  func viewDidLoad()
}

final class ProductDetailPresenter: ProductDetailPresenting {
  private var interactor: ProductDetailInteracting
  private weak var view: ProductDetailViewing?
  private var opening: ProductDetailOpening
  private var builder: ProductDetailViewModelBuilding
  private var router: ProductDetailRouting

  init(
    opening: ProductDetailOpening,
    interactor: ProductDetailInteracting,
    builder: ProductDetailViewModelBuilding,
    router: ProductDetailRouting,
    view: ProductDetailViewing
  ) {
    self.opening = opening
    self.interactor = interactor
    self.builder = builder
    self.router = router
    self.view = view
  }
    
  func viewDidLoad() {
    view?.showLoadingView()
    getProductDetail()
  }
    
  private func getProductDetail() {
    interactor.fetchProductDetail(id: opening.productId) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(data):
        DispatchQueue.main.async {
          self.updateView(with: data)
          self.view?.hideLoadingView()
        }
      case let .failure(error):
        DispatchQueue.main.async {
          self.handleError(errorMessage: error.localizedDescription)
        }
      }
    }
  }

  private func handleError(errorMessage: String) {
    let action = ErrorAction(title: Translations.backButton.rawValue) { [weak self] _ in
      self?.router.backToPreviousPage()
    }
    let model = ErrorModel(
      title: Translations.errorTitle.rawValue,
      description: errorMessage,
      action: action
    )
    self.router.showError(with: model)
  }
    
  private func updateView(with data: ProductDetailModel) {
    let dataSource = builder.buildDataSource(with: data)
    view?.update(with: dataSource)
  }
}
