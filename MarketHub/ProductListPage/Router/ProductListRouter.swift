//
//  ProductListRouter.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import UIKit

protocol ProductListRouting {
  func openDetailPage(with opening: ProductDetailOpening)
  func showError(with model: ErrorModel)
}

final class ProductListRouter: ProductListRouting {
  private unowned let viewController: UIViewController

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  func openDetailPage(with opening: ProductDetailOpening) {
    let detailVC = ProductDetailPageBuilder.build(openingModel: opening)
    if let navigation = viewController.navigationController {
      navigation.pushViewController(detailVC, animated: true)
    }
  }
    
  func showError(with model: ErrorModel) {
    let alertController = UIAlertController(
      title: model.title,
      message: model.description,
      preferredStyle: .alert
    )
    if let action = model.action {
      let backAction = UIAlertAction(title: action.title, style: .default, handler: action.handler)
      alertController.addAction(backAction)
    }
    viewController.present(alertController, animated: true)
  }
}
