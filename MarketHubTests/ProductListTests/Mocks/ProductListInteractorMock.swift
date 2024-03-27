//
//  ProductListInteractorMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductListInteractorMock: ProductListInteracting {
  var fetchProductListCalled = false
  var fetchProductListPage: String?
  var fetchProductListCompletion: ((ProductListResult) -> Void)?
  var mockResult: ProductListResult!

  func fetchProductList(page: String, completion: @escaping (ProductListResult) -> Void) {
    fetchProductListCalled = true
    fetchProductListPage = page
    fetchProductListCompletion = completion
    completion(mockResult)
  }
}
