//
//  ProductDetailInteractorMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductDetailInteractorMock: ProductDetailInteracting {
  var fetchProductDetailCalled = false
  var fetchProductDetailId: Int?
  var fetchProductDetailCompletion: ((ProductDetailResult) -> Void)?
  var mockResult: ProductDetailResult!

  func fetchProductDetail(id: Int, completion: @escaping (ProductDetailResult) -> Void) {
    fetchProductDetailCalled = true
    fetchProductDetailId = id
    fetchProductDetailCompletion = completion
    completion(mockResult)
  }
}
