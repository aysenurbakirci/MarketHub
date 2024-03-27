//
//  ProductListPageBuilder.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 11.01.2024.
//

import UIKit

final class ProductListPageBuilder {
  static func build() -> UIViewController {
    let interactor = ProductListInteractor()
    let formatter = PriceFormatter()
    let view = ProductListViewController()
    let builder = ProductListViewModelBuilder(priceFormatter: formatter)
    let router = ProductListRouter(viewController: view)
    let presenter = ProductListPresenter(
      interactor: interactor,
      view: view,
      router: router,
      builder: builder
    )
    view.presenter = presenter
    let navigation = UINavigationController(rootViewController: view)
    return navigation
  }
}
