//
//  ProductListViewMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductListViewMock: ProductListViewing {
  var updateCalled = false
  func update(with viewModels: ProductListViewModels) {
    updateCalled = true
  }
        
  var updatePaginationStatusCalled = false
  func updatePaginationStatus(as isEnabled: Bool) {
    updatePaginationStatusCalled = true
  }
    
  var finishPaginationLoadingCalled = false
  func finishPaginationLoading() {
    finishPaginationLoadingCalled = true
  }

  var showLoadingViewCalled = false
  func showLoadingView() {
    showLoadingViewCalled = true
  }

  var hideLoadingViewCalled = false
  func hideLoadingView() {
    hideLoadingViewCalled = true
  }
}
