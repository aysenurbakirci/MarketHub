//
//  ProductDetailRouterMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductDetailRouterMock: ProductDetailRouting {
  var backToPreviousPageCalled = false
  func backToPreviousPage() {
    backToPreviousPageCalled = true
  }

  var showErrorCalled = false
  var showErrorModel: ErrorModel?
  func showError(with model: ErrorModel) {
    showErrorCalled = true
    showErrorModel = model
  }
}
