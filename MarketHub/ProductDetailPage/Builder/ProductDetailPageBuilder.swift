//
//  ProductDetailPageBuilder.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 12.01.2024.
//

import UIKit

final class ProductDetailPageBuilder {
  static func build(openingModel: ProductDetailOpening) -> UIViewController {
    let interactor = ProductDetailInteractor()
    let formatter = PriceFormatter()
    let builder = ProductDetailViewModelBuilder(priceFormatter: formatter)
    let view = ProductDetailViewController()
    let router = ProductDetailRouter(viewController: view)
    let presenter = ProductDetailPresenter(
      opening: openingModel,
      interactor: interactor, 
      builder: builder, 
      router: router,
      view: view
    )
    view.presenter = presenter
    return view
  }
}
