//
//  ProductDetailRouter.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 13.01.2024.
//

import UIKit

protocol ProductDetailRouting {
  func backToPreviousPage()
  func showError(with model: ErrorModel)
}

final class ProductDetailRouter: ProductDetailRouting {
  private unowned let viewController: UIViewController
    
  init(viewController: UIViewController) {
    self.viewController = viewController
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
    
  func backToPreviousPage() {
    viewController.navigationController?.popViewController(animated: true)
  }
}
