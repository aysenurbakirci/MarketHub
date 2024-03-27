//
//  ProductListRouterMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductListRouterMock: ProductListRouting {
  var openDetailPageCalled = false
  var openDetailPageOpening: ProductDetailOpening?
  func openDetailPage(with opening: ProductDetailOpening) {
    openDetailPageCalled = true
    openDetailPageOpening = opening
  }

  var showErrorCalled = false
  var showErrorModel: ErrorModel?
  func showError(with model: ErrorModel) {
    showErrorCalled = true
    showErrorModel = model
  }
}
