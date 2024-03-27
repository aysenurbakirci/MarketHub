//
//  ProductDetailViewMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductDetailViewMock: ProductDetailViewing {
  var showLoadingViewCalled = false
  func showLoadingView() {
    showLoadingViewCalled = true
  }

  var hideLoadingViewCalled = false
  func hideLoadingView() {
    hideLoadingViewCalled = true
  }

  var updateCalled = false
  var updateData: ProductDetailViewModels?
  func update(with data: ProductDetailViewModels?) {
    updateCalled = true
    updateData = data
  }
}
