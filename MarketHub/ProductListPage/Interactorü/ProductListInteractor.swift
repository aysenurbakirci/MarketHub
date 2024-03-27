//
//  ProductListInteractor.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import Foundation

typealias ProductListResult = Result<ProductListModel, Error>

protocol ProductListInteracting {
  func fetchProductList(page: String, completion: @escaping (ProductListResult) -> Void)
}

final class ProductListInteractor: ProductListInteracting {
  func fetchProductList(page: String, completion: @escaping (ProductListResult) -> Void) {
    NetworkManager.shared.executeRequest(
      ProductAPI.listing(page: page), completion: completion
    )
  }
}
