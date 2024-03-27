//
//  ProductDetailInteractor.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import Foundation

typealias ProductDetailResult = Result<ProductDetailModel, Error>

protocol ProductDetailInteracting {
  func fetchProductDetail(id: Int, completion: @escaping (ProductDetailResult) -> Void)
}

final class ProductDetailInteractor: ProductDetailInteracting {
  func fetchProductDetail(id: Int, completion: @escaping (ProductDetailResult) -> Void) {
    NetworkManager.shared.executeRequest(
      ProductAPI.productDetail(id: id), completion: completion
    )
  }
}
